import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PaymentService {
  static Future<void> redirectToCheckout({
    required int amount,
    required String currency,
    required String title,
    required Map<String, dynamic> metadata,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('/api/create-checkout-session'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'amount': amount,
          'currency': currency,
          'title': title,
          'metadata': metadata,
          'successUrl': 'https://thegiftvaults.com/success',
          'cancelUrl': 'https://thegiftvaults.com/cancel',
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final checkoutUrl = jsonResponse['url'];

        if (await canLaunchUrl(Uri.parse(checkoutUrl))) {
          await launchUrl(Uri.parse(checkoutUrl), webOnlyWindowName: '_self');
        } else {
          throw 'Could not launch $checkoutUrl';
        }
      } else {
        print('Failed to create checkout session: ${response.body}');
      }
    } catch (e) {
      print('Error redirecting to checkout: $e');
    }
  }
}
