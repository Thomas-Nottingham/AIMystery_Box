import 'dart:convert';
import 'dart:async'; // Import for TimeoutException
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SandBox_Gifts_Backup/providers/budget_provider2.dart';

class OpenAIService2 {
  final List<Map<String, String>> messages = [];
  int questionCount = 0;
  bool addToCartAvailable = false;
  int messagesLeft = maxSecondaryMessages;

  static const int maxInitialQuestions = 5;
  static const int maxSecondaryMessages = 4;

  static const String initialConversationalPrompt = """
You are a gift-finding chatbot. Your ONLY task is to ask the very first question. Ask the user for their friend's hobbies or interests. Do not greet them. Do not add any other text. Just ask the question. Respond ONLY in JSON format with a 'message' key containing your question.
""";

  static const String followUpConversationalPrompt = """
You are a gift-finding chatbot. Your ONLY task right now is to ask an insightful follow-up question based on the user's last answer.

Your goal is to uncover more information that would be useful for gift finding. 

Follow these rules:
1.  **Ask open-ended questions.** Avoid simple yes/no questions. 
2.  **Try and ensure a human can look at the conversation and be able to find a gift based on what they see.** 3.  **Handle unhelpful answers.** If the user says "no" or "I don't know", do not just move on. Rephrase the question or pivot slightly.
4.  **Do not make statements. Just ask one question.**

Respond ONLY in JSON format with a 'message' key containing your single, insightful question.
""";

  static const String recoveryAgentPrompt = """
You are a helpful AI assistant. A previous analysis determined there wasn't enough information to find a gift. Get the user to elbaroate more on what their friend likes. Respond ONLY in JSON format with a 'message' key.
""";

  static const String continuationAgentPrompt = """
You are a helpful AI assistant. A previous analysis determined there IS enough information for a great gift suggestion. Let the user know that you have generated 3 gift ideas and they can check those out by clicking the gift summary button but you would be happy to take any other details they want to share. Respond ONLY in JSON format with a 'message' key""";

  // --- CLEANED UP EVALUATOR PROMPT ---
  static const String evaluatorPrompt = """
You are an AI assistant skilled at identifying gift-giving opportunities. Your goal is to find a good balance: you need enough detail to avoid generic gifts, but you don't need a full biography.

Evaluate the conversation with this mindset: "Has the user provided at least one specific detail, emotion, or context that makes the general topic more personal?"

Consider the following:
- **Look for an 'Extra Layer':** A general topic like "tennis" or a single-word answer is **not sufficient on its own**. It becomes sufficient only when an 'extra layer' of detail is added. This could be a specific behavior ("plays every weekend"), an emotion ("is obsessed with..."), or a simple preference ("loves watching the big tournaments"). You need the user to elaborate, even just a little.
- **Context is Key:** Look for any clue that adds personality. "Loves" is better than "likes." "Is stressed and enjoys baths" is a strong signal.
- **Be Wary of Vague Answers:** A conversation with only single-word topics ("sports", "movies") and no additional detail is likely insufficient.

After your evaluation, respond ONLY in this JSON format:
{
  "sufficient_data": boolean,
  "reasoning": "A short, clear justification for your decision. If sufficient, mention the key detail that tipped the scale. If insufficient, explain what kind of extra detail is needed (e.g., 'The user mentioned 'sports' but didn't specify which sport or how their friend enjoys it.')."
}
""";

  static const String giftSummaryPrompt = """
You are a thoughtful gift profiler. Your task is to synthesize the entire provided conversation history to understand the essence of the person for whom the gift is intended.
Based on this, create a short, intriguing summary (25-40 words) of the *person* and the *theme* of the gift you have in mind.
DO NOT mention or hint at any specific products. Focus on the person's character, passions, or needs that the conversation revealed.
The tone should be warm, personal, and slightly mysterious. dont include anything about the users age or budget.
Respond ONLY in this JSON format:
{
  "summary": "Your generated summary here."
}
""";

  static const String giftChoicesPrompt = """
You are a practical gift suggestion AI. Based on the provided conversation history, your task is to generate exactly three distinct, tangible, and simple gift ideas. These should be concrete items, not experiences or concepts.

Follow these rules:
1.  Analyze the conversation to understand the recipient's interests and the user's budget.
2.  Suggest three different physical products that align with those interests.
3.  Keep the descriptions concise (5-10 words each).
4.  Do not number the list.

Respond ONLY in this JSON format:
{
  "choices": [
    "Your first gift idea here",
    "Your second gift idea here",
    "Your third gift idea here"
  ]
}
""";

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
        Provider.of<BudgetProvider2>(
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
        Provider.of<BudgetProvider2>(
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
            """You are speaking to $name with a budget of $budget. they're buying for someone else. Act as an intuitive gift finder. Guide the user through an engaging experience by asking thoughtful questions
Your goal is to uncover something about the user that leads to a unique and meaningful surprise gift.
Ask your questions one at a time, Keep the tone warm, curious.
The experience should feel like a mix between a personality quiz and a treasure hunt. Make the user feel like they are going to receive a surprise.

Follow these rules:
1. Always speak directly with the user.
2. Never tell the user what the product is or tell them something that would let them easily understand.
3. Create a conversational style flow, considering their message as if they were talking to another person.
4. Keep responses under 30 words.
5. Never consider products that could be deemed as risky.
6. Never consider products related to food/consumables, medical items.
7. Remember the budget and do not find realistic products within that budget.""",
      });
    }

    messages.add({'role': 'user', 'content': userMessage});
    if (messages.length > 20) messages.removeRange(3, messages.length - 2);

    if (questionCount < maxInitialQuestions) {
      final systemPrompt =
          questionCount == 0
              ? initialConversationalPrompt
              : followUpConversationalPrompt;

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

  // --- CORRECTED getGiftChoices METHOD ---
  Future<List<String>> getGiftChoices() async {
    // Uses the live 'messages' list, not context/provider
    final tempMessages = List<Map<String, String>>.from(messages);
    tempMessages.insert(0, {'role': 'system', 'content': giftChoicesPrompt});

    try {
      final res = await http
          .post(
            Uri.parse('/api/openai'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "model": "gpt-4o",
              "response_format": {"type": "json_object"},
              "messages": tempMessages,
              "max_tokens": 200,
              "temperature": 0.6,
            }),
          )
          .timeout(const Duration(seconds: 20)); // Added timeout for safety

      if (res.statusCode == 200) {
        final content =
            jsonDecode(
              utf8.decode(res.bodyBytes),
            )['choices'][0]['message']['content'];
        final jsonContent = jsonDecode(content);
        List<String> choices = List<String>.from(jsonContent['choices']);
        return choices;
      }
    } catch (e) {
      print('Error in getGiftChoices: $e');
    }
    // Return a fallback list only if the API call fails or times out
    return [
      "A thoughtful book",
      "A high-quality water bottle",
      "A unique coffee mug",
    ];
  }

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

  static const String _transcriptSummarizerPrompt = """
You will be given a chat transcript. The user's messages are very repetitive as they repeat previous context in every message.
Your task is to rewrite the conversation to be more natural and concise by removing the duplicated information from the user's side.
The assistant's messages should remain unchanged.
Maintain the exact back-and-forth 'User:' and 'Assistant:' format.
""";

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
          "model": "gpt-4o",
          "messages": messagesForSummarizing,
          "max_tokens": 400,
          "temperature": 0.1,
        }),
      );

      if (res.statusCode == 200) {
        return jsonDecode(
          utf8.decode(res.bodyBytes),
        )['choices'][0]['message']['content'];
      } else {
        print('AI summarization failed: ${res.body}');
        return cleanTranscript;
      }
    } catch (e) {
      print('Error summarizing clean transcript: $e');
      return cleanTranscript;
    }
  }
}
