import 'dart:convert';
import 'package:SandBox_Gifts_Backup/secrets.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
    final List<Map<String, String>> messages = [];

  Future<String> isArtPromptAPI(String title, double price) async {
        final prompt = "Generate a very short response (2 sentences). Generate a response for a mystery box titled '$title' priced at \$$price. Make sure to mention the title and the price. Dont lie you're here to help them. Most importantly you need ask them questions about themselves to get an idea of whawt surprise gift they may want. NEVER TELL THEM WHAT THEY'RE GETTING its a surprise";
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
          {
            'role': 'user',
            'content': 
              prompt,
          }
        ],
        "max_tokens": 30,
        "temperature": 0.7, 
       }),
       );
       //print(res.body); 
    
        String content = 
        jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

      return await chatGPTAPI(prompt); 
    } catch (e) {
      return e.toString();
    }
  }
  
  Future<String> chatGPTAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': 'you need to help the user find a gift they want, but you cant tell them what it is, its a surprise $prompt only reply with 2 sentences',
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

        messages.add({
          'role': 'assistant',
          'content': content,
        });
      print(content);
      return content; 

       }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }



}