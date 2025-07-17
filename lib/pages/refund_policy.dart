import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // For TapGestureRecognizer
import 'package:url_launcher/url_launcher.dart'; // For launching URLs
import 'package:SandBox_Gifts_Backup/footer.dart';

// Adjust these imports based on your actual project structure
import 'package:SandBox_Gifts_Backup/presentation/BaseLayout.dart';
import 'package:SandBox_Gifts_Backup/widgets/pallete.dart';

class ReturnPolicyPage extends StatelessWidget {
  const ReturnPolicyPage({super.key});

  // Helper to launch mailto link
  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    if (!await launchUrl(emailUri)) {
      debugPrint('Could not launch $emailUri');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle paragraphStyle = TextStyle(
      color: Colors.grey[300],
      fontSize: 15,
      height: 1.5,
    );

    final TextStyle linkStyle = TextStyle(
      color: Colors.blue[400],
      decoration: TextDecoration.underline,
      decorationColor: Colors.blue[400],
      fontSize: 15,
      height: 1.5,
    );

    return BaseLayout(
      appBarColor: const Color(0xFF1F1F1F),
      text_title: Text(
        'Return Policy',
        style: TextStyle(color: Pallete.whiteColor),
      ),
      child: Container(
        color: const Color.fromARGB(255, 36, 36, 36),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Last updated May 22, 2025',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 20),

                Paragraph(
                  "Thank you for your purchase. We hope you are happy with your purchase. However, if you are not completely satisfied with your purchase for any reason, you may return it to us for a refund only. Please see below for more information on our return policy.",
                ),
                const SizedBox(height: 30),

                SectionTitle('RETURNS'),
                const SizedBox(height: 10),
                Paragraph(
                  "All returns must be postmarked within fourteen (14) days of the purchase date. All returned items must be in new and unused condition, with all original tags and labels attached.",
                ),
                const SizedBox(height: 30),

                SectionTitle('RETURN PROCESS'),
                const SizedBox(height: 10),
                Paragraph(
                  "To return an item, place the item securely in its original packaging, and mail your return to the following address:",
                ),
                const SizedBox(height: 10),
                Text(
                  "__________\nAttn: Returns\n__________\n__________",
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 15,
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 10),
                Paragraph(
                  "Please note, you will be responsible for all return shipping charges. We strongly recommend that you use a trackable method to mail your return.",
                ),
                const SizedBox(height: 30),

                SectionTitle('REFUNDS'),
                const SizedBox(height: 10),
                Paragraph(
                  "After receiving your return and inspecting the condition of your item, we will process your return. Please allow at least fourteen (14) days from the receipt of your item to process your return. Refunds may take 1-2 billing cycles to appear on your credit card statement, depending on your credit card company. We will notify you by email when your return has been processed.",
                ),
                const SizedBox(height: 30),

                SectionTitle('EXCEPTIONS'),
                const SizedBox(height: 10),
                Paragraph(
                  "For defective or damaged products, please contact us at the contact details below to arrange a refund or exchange.",
                ),
                const SizedBox(height: 10),
                Paragraph("Please Note:"),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      style: paragraphStyle,
                      children: const [
                        TextSpan(
                          text:
                              "• Refunds are only applicable according to UK Legislation.",
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                SectionTitle('QUESTIONS'),
                const SizedBox(height: 10),
                Paragraph(
                  "If you have any questions concerning our return policy, please contact us at:",
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      style: linkStyle,
                      text: 'thegiftvaultscs@gmail.com',
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              _launchEmail('thegiftvaultscs@gmail.com');
                            },
                    ),
                  ),
                ),
                const SizedBox(height: 60),

                Center(child: MyFooter()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// SectionTitle and Paragraph helpers

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Pallete.whiteColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class Paragraph extends StatelessWidget {
  final String text;
  const Paragraph(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.grey[300], fontSize: 15, height: 1.5),
      textAlign: TextAlign.justify,
    );
  }
}
