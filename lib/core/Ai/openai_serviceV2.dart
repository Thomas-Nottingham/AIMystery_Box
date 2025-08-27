import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/budget_provider.dart'; // Ensure this path is correct

class OpenAIService {
  final List<Map<String, String>> messages = [];
  int questionCount = 0;
  bool addToCartAvailable = false;
  int messagesLeft = maxSecondaryMessages;

  static const int maxInitialQuestions = 5;
  static const int maxSecondaryMessages = 4;

  // --- All your existing prompts remain the same ---
  static const List<String> questionerPrompts = [
    // First prompt for
    """
You are a surprise gift-finding assistant that will help the user find a gift for themselves. What's the mood for this? Are we celebrating a win, looking for a little pick-me-up, or just indulging in something? Respond ONLY in JSON format with a 'message' key.
  """,
    // 1: Deep dive into their passionate hobby
    """
You are a surprise gift-finding assistant that will help the user find a gift for themselves. Think about their interests. What's a specific time, place or object that would be interesting to them? Respond ONLY in JSON format with a 'message' key containing the question.
  """,
    // 2: Perfect relaxation scenario
    """
You are a surprise gift-finding assistant that will help the user find a gift for themselves. Thinking along those lines, Is there a skill they've always wanted to learn, or an experience they've dreamed of trying? Respond ONLY in JSON format with a 'message' key.
  """,

    // 3: Aspirational skill or experience
    """
You are a surprise gift-finding assistant that will help the user find a gift for themselves. With that in mind, is there any small, recurring frustration that a thoughtful gift could solve? Ask a question that uncovers that aspiration so you can suggest a gift that helps them take the first step. Respond ONLY in JSON format with a 'message' key.
  """,

    // 4: Everyday convenience win
    """
You are a surprise gift-finding assistant that will help the user find a gift for themselves. Relating to what has been discussed, is there a cherished memory or a moment from their past they love to talk about?. Respond ONLY in JSON format with a 'message' key.
  """,
  ];

  static const String recoveryAgentPrompt = """
You are a helpful AI assistant. A previous analysis determined there wasn't enough information to find a gift. Your new goal is to recover the conversation. Be friendly and a bit more direct. Ask the user for specific hobbies, interests, or types of things the recipient might enjoy. It's a surprise, so be subtle. Respond ONLY in JSON format with a 'message' key.
""";

  static const String continuationAgentPrompt = """
You are a helpful AI assistant. A previous analysis determined there IS enough information for a great gift suggestion. Your new goal is to be pleasantly conversational. Let the user know you have enough information and can click the gift summary button but you would be happy to take any other details they want to share. Respond ONLY in JSON format with a 'message' key.
""";

  static const String evaluatorPrompt = """
You are an AI assistant skilled at identifying gift-giving opportunities in a conversation. Your goal is to determine if the provided message history contains enough personal information to suggest a thoughtful gift, moving beyond generic options.

Evaluate the conversation with this mindset: "If I were a helpful friend, could I use these clues to come up with a decent gift idea?"

Consider the following:
- **Look for Hooks:** Is there any mention of a hobby, a passion, a complaint, or a desire? Even a general topic like "movies" or "baking" is a valid hook.
- **Context is Key:** Is there any emotion or context attached? "Loves" is better than "likes." "Is stressed and enjoys baths" is a strong clue.
- **Reasonable Inference:** It's okay to make logical connections. If a user mentions they are a "new homeowner" and "love hosting," you can infer that gifts related to home entertaining would be suitable.

The standard for sufficiency is not a guaranteed perfect gift, but a reasonable chance of finding a good one.

After your evaluation, respond ONLY in this JSON format:
{
  "sufficient_data": boolean,
  "reasoning": "A short, clear justification for your decision. If sufficient, mention the key pieces of information that could lead to a gift idea. If insufficient, explain what's missing."
}
""";

  static const String giftSummaryPrompt = """
You are a thoughtful gift profiler. Your task is to synthesize the entire provided conversation history to understand the essence of the person for whom the gift is intended.
Based on this, create a short, intriguing summary (25-40 words) of the *person* and the *theme* of the gift you have in mind.
DO NOT mention or hint at any specific products. Focus on the person's character, passions, or needs that the conversation revealed.
The tone should be warm, personal, and slightly mysterious.
Respond ONLY in this JSON format:
{
  "summary": "Your generated summary here."
}
""";

  // --- All your other methods like giftFinderBot, evaluateGiftData etc. remain here unchanged ---
  void clearMessages() {
    messages.clear();
    questionCount = 0;
    addToCartAvailable = false;
    messagesLeft = maxSecondaryMessages;
  }

  Future<Map<String, dynamic>?> getGiftBotQuestion(
    String systemPrompt,
    BuildContext context,
  ) async {
    final tempMessages = List<Map<String, String>>.from(messages);
    tempMessages.insert(0, {'role': 'system', 'content': systemPrompt});

    try {
      final res = await http.post(
        Uri.parse('/api/openai'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "model": "gpt-4o",
          "response_format": {"type": "json_object"},
          "messages": tempMessages,
          "max_tokens": 100,
          "temperature": 0.4,
        }),
      );

      if (res.statusCode == 200) {
        final content =
            jsonDecode(
              utf8.decode(res.bodyBytes),
            )['choices'][0]['message']['content'];
        final jsonContent = jsonDecode(content);
        messages.add({'role': 'assistant', 'content': content});
        // This saves the raw history during the chat
        Provider.of<BudgetProvider>(
          context,
          listen: false,
        ).setConversationHistory(jsonEncode(messages));
        return jsonContent;
      } else {
        print('API Error: ${res.statusCode} - ${res.body}');
      }
    } catch (e) {
      print('Error in getGiftBotQuestion: $e');
    }
    return null;
  }

  Future<Map<String, dynamic>?> evaluateGiftData(BuildContext context) async {
    final tempMessages = List<Map<String, String>>.from(messages);
    tempMessages.insert(0, {'role': 'system', 'content': evaluatorPrompt});

    try {
      final res = await http.post(
        Uri.parse('/api/openai'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "model": "gpt-4o",
          "response_format": {"type": "json_object"},
          "messages": tempMessages,
          "max_tokens": 100,
          "temperature": 0.4,
        }),
      );

      if (res.statusCode == 200) {
        final content =
            jsonDecode(
              utf8.decode(res.bodyBytes),
            )['choices'][0]['message']['content'];
        final jsonContent = jsonDecode(content);
        messages.add({'role': 'system', 'content': content});
        // This also saves the raw history during the chat
        Provider.of<BudgetProvider>(
          context,
          listen: false,
        ).setConversationHistory(jsonEncode(messages));
        return jsonContent;
      }
    } catch (e) {
      print('Error in evaluateGiftData: $e');
    }
    return {
      "sufficient_data": false,
      "reasoning": "Could not evaluate due to error.",
    };
  }

  Future<Map<String, dynamic>> giftFinderBot(
    String userMessage, {
    required BuildContext context,
    String? name,
    String? budget,
  }) async {
    Map<String, dynamic> response(String msg, bool showCart) {
      return {'message': msg, 'showAddToCart': showCart};
    }

    if (messages.isEmpty && name != null && budget != null) {
      messages.add({
        'role': 'system',
        'content':
            """You are speaking to $name with a budget of $budget. Act as an intuitive gift finder. Guide the user through an engaging experience by asking a few thoughtful questions about their personality, interests, and preferences.
Your goal is to uncover something about the user that leads to a unique and meaningful surprise gift.
Ask your questions one at a time, building towards a reveal, Keep the tone warm, curious, and a little playful.
The experience should feel like a mix between a personality quiz and a treasure hunt. Make the user feel like they are going to receive a surprise that is 

Follow these rules:
1. Always speak directly with the user.
3. Never tell the user what the product is or tell them something that would let them easily understand. 
4. Create a conversational style flow, considering their message as if they were talking to another person.
5. Keep responses under 30 words
6. Never consider products that could be deemeed as risky.
7. Never consider prooducts related to food/consumables, medical items, or clothing/shoes.
8. Remember the budget and do not find realistic products within that budget.""",
      });
    }

    messages.add({'role': 'user', 'content': userMessage});
    if (messages.length > 20) messages.removeRange(3, messages.length - 2);

    if (questionCount < maxInitialQuestions) {
      final systemPrompt = questionerPrompts[questionCount];
      final botResponse = await getGiftBotQuestion(systemPrompt, context);
      if (botResponse != null && botResponse.containsKey('message')) {
        questionCount++;
        return response(botResponse['message'], addToCartAvailable);
      } else {
        return response(
          "Sorry, something went wrong. Please try again.",
          false,
        );
      }
    }

    if (questionCount == maxInitialQuestions && !addToCartAvailable) {
      final evaluation = await evaluateGiftData(context);
      addToCartAvailable = evaluation?["sufficient_data"] ?? false;
    }

    if (questionCount >= maxInitialQuestions && messagesLeft > 0) {
      final systemPrompt =
          addToCartAvailable ? continuationAgentPrompt : recoveryAgentPrompt;
      final botResponse = await getGiftBotQuestion(systemPrompt, context);
      if (botResponse != null && botResponse.containsKey('message')) {
        messagesLeft--;
        if (!addToCartAvailable) {
          final evaluation = await evaluateGiftData(context);
          if (evaluation?["sufficient_data"] == true) {
            addToCartAvailable = true;
          }
        }
        return response(botResponse['message'], addToCartAvailable);
      } else {
        return response(
          "Sorry, something went wrong. Please try again.",
          addToCartAvailable,
        );
      }
    }

    if (messagesLeft == 0) {
      final msg =
          addToCartAvailable
              ? "Your gift is waiting! Just click the button to proceed. If you'd like to keep talking, please start a new conversation."
              : "Sorry, we couldn't find you a gift this time.";
      return response(msg, addToCartAvailable);
    }

    return response("Conversation processing error. Please try again.", false);
  }

  Future<String> summarizeGiftPersona(BuildContext context) async {
    final tempMessages = List<Map<String, String>>.from(messages);
    tempMessages.insert(0, {'role': 'system', 'content': giftSummaryPrompt});

    try {
      final res = await http.post(
        Uri.parse('/api/openai'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "model": "gpt-4o",
          "response_format": {"type": "json_object"},
          "messages": tempMessages,
          "max_tokens": 150,
          "temperature": 0.5,
        }),
      );

      if (res.statusCode == 200) {
        final content =
            jsonDecode(
              utf8.decode(res.bodyBytes),
            )['choices'][0]['message']['content'];
        final jsonContent = jsonDecode(content);
        return jsonContent['summary'] ??
            "A special surprise tailored just for them.";
      }
    } catch (e) {
      print('Error in summarizeGiftPersona: $e');
    }
    return "A special surprise tailored just for them.";
  }

  // --- STEP 1: LOCAL CLEANING METHOD ---
  Future<String> createCleanTranscript(String rawJsonHistory) async {
    try {
      final List<dynamic> messages = jsonDecode(rawJsonHistory);
      final buffer = StringBuffer();

      for (var message in messages) {
        final role = message['role'];
        final content = message['content'];

        if (role == 'user') {
          buffer.writeln('User: $content');
        } else if (role == 'assistant') {
          try {
            final assistantMessage = jsonDecode(content)['message'];
            buffer.writeln('Assistant: $assistantMessage');
          } catch (e) {
            print('Could not parse assistant message: $content');
          }
        }
      }
      return buffer.toString();
    } catch (e) {
      print('Error creating clean transcript: $e');
      return "Could not generate a clean transcript due to a formatting error.";
    }
  }

  // --- NEW PROMPT FOR THE SUMMARIZER ---
  static const String _transcriptSummarizerPrompt = """
You will be given a chat transcript. The user's messages are very repetitive as they repeat previous context in every message.
Your task is to rewrite the conversation to be more natural and concise by removing the duplicated information from the user's side.
The assistant's messages should remain unchanged.
Maintain the exact back-and-forth 'User:' and 'Assistant:' format.
""";

  // --- STEP 2: NEW AI SUMMARIZATION METHOD ---
  Future<String> summarizeCleanTranscript(String cleanTranscript) async {
    final messagesForSummarizing = [
      {'role': 'system', 'content': _transcriptSummarizerPrompt},
      {'role': 'user', 'content': cleanTranscript},
    ];

    try {
      final res = await http.post(
        Uri.parse('/api/openai'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "model":
              "gpt-4o", // You could use a faster model like gpt-3.5-turbo here too
          "messages": messagesForSummarizing,
          "max_tokens": 400, // Allow enough space for the full conversation
          "temperature": 0.1,
        }),
      );

      if (res.statusCode == 200) {
        return jsonDecode(
          utf8.decode(res.bodyBytes),
        )['choices'][0]['message']['content'];
      } else {
        // If the AI call fails, return the clean but unsummarized transcript
        print('AI summarization failed: ${res.body}');
        return cleanTranscript;
      }
    } catch (e) {
      print('Error summarizing clean transcript: $e');
      // If an error occurs, return the clean but unsummarized transcript
      return cleanTranscript;
    }
  }
}
