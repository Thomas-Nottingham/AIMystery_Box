import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final List<Map<String, String>> messages = [];
  final List<Map<String, String>> Amazon_Search_Data = [];

  Future<String> isArtPromptAPI(String title, double price) async {
    const openAIAPIKey =
        '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';
    final prompt =
        "Generate a very short response (2 sentences). Generate a response for a mystery box titled '$title' priced at \$$price. Make sure to mention the title and the price. Dont lie you're here to help them. Most importantly you need ask them questions about themselves to get an idea of what surprise gift they may want. NEVER TELL THEM WHAT THEY'RE GETTING its a surprise";
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {'role': 'user', 'content': prompt},
          ],
          "max_tokens": 30,
          "temperature": 0.7,
        }),
      );
      //print(res.body);

      String content = jsonDecode(res.body)['choices'][0]['message']['content'];
      content = content.trim();

      return await chatGPTAPI(prompt);
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    const openAIAPIKey =
        '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';
    messages.add({
      'role': 'user',
      'content':
          'you need to help the user find a gift they want, but you cant tell them what it is, its a surprise $prompt only reply with 2 sentences',
    });
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
          "max_tokens": 60,
          "temperature": 0.7,
        }),
      );

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();
        messages.add({'role': 'assistant', 'content': content});
        await productFinder(content);
        return content;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }

  Future productFinder(String productDetails) async {
    const openAIAPIKey =
        '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';
    final prompt =
        "Can you break these messages down into smaller keywords that we can use to find amazon products online? $productDetails";

    final res = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $openAIAPIKey',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {'role': 'user', 'content': prompt},
        ],
        "max_tokens": 30,
        "temperature": 0.7,
      }),
    );
    //print(res.body);

    String content = jsonDecode(res.body)['choices'][0]['message']['content'];
    content = content.trim();
    Amazon_Search_Data.add({'content': content});

    return null;
  }
}
