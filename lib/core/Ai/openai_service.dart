import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final List<Map<String, String>> messages = []; // Conversation history

  int estimateTokens(String text) {
    return (text.length / 4).ceil(); // Rough average: 1 token = ~4 characters
  }

  Future<String> AIChatBot(
    String userMessage, {
    String? name,
    String? occasion,
    String? age,
    String? gender,
    String? interests,
    String? budget,
  }) async {
    const groqAPIKey =
        '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'; // Replace with your actual Groq API key

    if (messages.isEmpty && name != null) {
      final initialPrompt = """
You are speaking to $name gender: $gender, aged: $age budget of $budget. Gather information from them to tailor a gift to them 
they are interested in $interests You are an assistant helping users find surprise gifts. Follow these rules:
1. you are speaking directly with the user talk to them but in a normal converational way.
2. Try and figure out what product to get them.
3. It has to be a surprise you arent allowed to tell them what it is or could be. 
4. ask follow up questions in a conversational way.
5. max 30 word responses.
6. No clothes, shoes or food.
7. Remember the budget and be realistic with products they could get with that budget.
""";

      messages.add({'role': 'system', 'content': initialPrompt});
    }

    messages.add({'role': 'user', 'content': userMessage});

    final rules = {
      'role': 'system',
      'content': """
    Focus on users most recent input
    """,
    };

    messages.removeWhere((msg) => msg['content'] == rules['content']);
    messages.insert(0, rules);

    // Estimate tokens (roughly)
    int totalInputTokens = messages.fold(
      0,
      (sum, msg) => sum + estimateTokens(msg['content'] ?? ''),
    );
    const int maxOutputTokens = 100;

    print('🔢 Estimated input tokens: $totalInputTokens');

    try {
      final res = await http.post(
        Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $groqAPIKey',
        },
        body: jsonEncode({
          "model": "llama3-8b-8192", // Groq-supported model
          "messages": messages,
          "max_tokens": maxOutputTokens,
          "temperature": 0.7,
        }),
      );

      if (res.statusCode == 200) {
        final decodedBody = utf8.decode(res.bodyBytes);
        String content =
            jsonDecode(decodedBody)['choices'][0]['message']['content'].trim();

        messages.add({'role': 'assistant', 'content': content});
        print("messages: $messages");

        if (messages.length > 10) {
          messages.removeRange(3, messages.length - 0);
        }

        return content;
      } else {
        print("❌ Status Code: ${res.statusCode}");
        print("❌ Response: ${res.body}");
        return 'An internal error occurred';
      }
    } catch (e) {
      return e.toString();
    }
  }
}
