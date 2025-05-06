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
    int? age,
    String? gender,
    String? interests,
    double? budget,
  }) async {
    const openAIAPIKey =
        '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'; // Keep your key safe!

    if (messages.isEmpty && name != null) {
      final initialPrompt = """
          You are speaking to $name gender: $gender, aged: $age  budget of $budget. Gather information from them to tailor a gift to them 
          they are interested in $interests. 
          """;

      messages.add({'role': 'system', 'content': initialPrompt});
    }

    messages.add({'role': 'user', 'content': userMessage});

    final rules = {
      'role': 'system',
      'content': """
You are an assistant helping users find surprise gifts. Follow these rules:
1. you are speaking directly with the user speak to them
2. Never tell the user what gift they are getting. its a surprise.
3. Ask follow-up questions 
3. Keep responses concise (max 25 words).
4. No clothes, shoes or food
""",
    };

    // Remove any previous instance of the rules from the conversation history
    messages.removeWhere((msg) => msg['content'] == rules['content']);

    messages.insert(0, rules);

    // ✅ Estimate input tokens
    int totalInputTokens = 0;
    for (var msg in messages) {
      totalInputTokens += estimateTokens(msg['content'] ?? '');
    }

    const int maxOutputTokens = 120;
    final estimatedTotalTokens = totalInputTokens + maxOutputTokens;

    // ✅ Estimate cost (GPT-3.5-Turbo pricing as of 2024)
    final estimatedCost =
        ((totalInputTokens * 0.0015) + (maxOutputTokens * 0.002)) / 1000;

    // final estimatedCost =
    //     ((totalInputTokens * 0.01) + (maxOutputTokens * 0.03)) / 1000;

    print('🔢 Estimated input tokens: $totalInputTokens');
    print('🧠 Estimated total tokens (with output): $estimatedTotalTokens');
    print('💰 Estimated cost: \$${estimatedCost.toStringAsFixed(6)}');

    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
          "max_tokens": 100,
          "temperature": 0.3,
        }),
      );

      if (res.statusCode == 200) {
        final decodedBody = utf8.decode(res.bodyBytes);
        String content =
            jsonDecode(decodedBody)['choices'][0]['message']['content'];
        content = content.trim();

        messages.add({'role': 'assistant', 'content': content});
        print("messages: $messages");

        if (messages.length > 10) {
          messages.removeRange(3, messages.length - 0);
        }

        return content;
      }

      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }

  // Future productFinder(String productDetails) async {
  //   const openAIAPIKey =
  //       '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';
  //   final prompt =
  //       "Can you break these messages down into smaller keywords that we can use to find amazon products online? $productDetails";

  //   final res = await http.post(
  //     Uri.parse('https://api.openai.com/v1/chat/completions'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $openAIAPIKey',
  //     },
  //     body: jsonEncode({
  //       "model": "gpt-3.5-turbo",
  //       "messages": [
  //         {'role': 'user', 'content': prompt},
  //       ],
  //       "max_tokens": 30,
  //       "temperature": 0.7,
  //     }),
  //   );
  //   //print(res.body);

  //   String content = jsonDecode(res.body)['choices'][0]['message']['content'];
  //   content = content.trim();
  //   Amazon_Search_Data.add({'content': content});

  //   return null;
  // }
}
