// In a new file, e.g., lib/pages/success_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart'; // Add `intl` to your pubspec.yaml for date formatting

class SuccessPage extends StatefulWidget {
  final String sessionId;
  const SuccessPage({super.key, required this.sessionId});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  // This will hold the data we fetch from the server
  late Future<Map<String, dynamic>> _sessionData;

  @override
  void initState() {
    super.initState();
    _sessionData = _fetchSessionData();
  }

  // Fetches the checkout session details from your backend
  Future<Map<String, dynamic>> _fetchSessionData() async {
    if (widget.sessionId.isEmpty) {
      throw Exception('No session ID provided.');
    }
    // Calls the /api/session route you created earlier
    final response = await http.get(
      Uri.parse('/api/session?id=${widget.sessionId}'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load session data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212), // A dark background
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _sessionData,
          builder: (context, snapshot) {
            // --- Show a loading spinner while fetching data ---
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            // --- Show an error message if something went wrong ---
            if (snapshot.hasError) {
              return Text(
                'Error loading order details: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              );
            }

            // --- Once data is loaded, display the confirmation ---
            if (snapshot.hasData) {
              final session = snapshot.data!;
              final customerEmail =
                  session['customer_details']?['email'] ?? 'your email';
              final total = (session['amount_total'] / 100).toStringAsFixed(2);
              final paymentIntentId = session['payment_intent'];
              final date = DateFormat('dd MMMM yyyy').format(
                DateTime.fromMillisecondsSinceEpoch(session['created'] * 1000),
              );

              return Container(
                padding: const EdgeInsets.all(32.0),
                constraints: const BoxConstraints(maxWidth: 500),
                decoration: BoxDecoration(
                  color: const Color(0xff1e1e1e),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 70,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Thank You For Your Order!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'A confirmation receipt has been sent to $customerEmail.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                    ),
                    const Divider(height: 48, color: Color(0xff333333)),
                    _buildDetailRow('Order Number:', paymentIntentId),
                    _buildDetailRow('Date:', date),
                    _buildDetailRow('Total:', '£$total', isTotal: true),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => context.go('/home'),
                      child: const Text(
                        'RETURN TO HOMEPAGE',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Text(
              'Something went wrong.',
              style: TextStyle(color: Colors.white),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16, color: Colors.grey[400])),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
