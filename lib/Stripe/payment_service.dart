import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PaymentService {
  static const String _serverUrl =
      'http://192.168.75.51:4242'; // Replace with your server URL

  // Method to create a PaymentIntent
  static Future<String?> createPaymentIntent(
    int amount,
    String currency,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_serverUrl/create-payment-intent'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'amount': amount, 'currency': currency}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['clientSecret'];
      } else {
        print('Failed to create payment intent: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Method to process the payment
  static Future<void> processPayment(String clientSecret) async {
    try {
      // Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Your App Name',
          customerId: 'auto', // Optional: Use a customer ID if you have one
          customerEphemeralKeySecret:
              'auto', // Optional: Use an ephemeral key if needed
          style:
              ThemeMode.light, // Optional: Set the theme for the payment sheet
          billingDetails: BillingDetails(
            email: 'test@example.com', // Replace with user email
            name: 'Test User', // Replace with user name
          ),
        ),
      );

      // Present the payment sheet
      await Stripe.instance.presentPaymentSheet();
      print('Payment successful!');
    } catch (e) {
      print('Payment failed: $e');
      throw e; // Re-throw the error to handle it in the calling method
    }
  }

  // Method to create a Checkout Session and redirect to Stripe Checkout
  static Future<void> redirectToCheckout(
    int amount,
    String currency, {
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_serverUrl/create-checkout-session'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'amount': amount,
          'currency': currency,
          'successUrl':
              'http://localhost:8080/success', // Replace with your success URL
          'cancelUrl': 'http://localhost:8080/cancel',
          'title': "Surprise Gift",
          'metadata': metadata, // Pass metadata to the server
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final checkoutUrl = jsonResponse['url'];

        if (await canLaunch(checkoutUrl)) {
          await launch(checkoutUrl);
        } else {
          throw 'Could not launch $checkoutUrl';
        }
      } else {
        print('Failed to create checkout session: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
