import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:SandBox_Gifts_Backup/presentation/BaseLayout.dart';
import 'package:SandBox_Gifts_Backup/widgets/pallete.dart';
import 'package:SandBox_Gifts_Backup/providers/budget_provider2.dart';
import 'package:SandBox_Gifts_Backup/Stripe/payment_service.dart';
import 'package:uuid/uuid.dart';
import 'package:SandBox_Gifts_Backup/footer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartPage2 extends StatefulWidget {
  const CartPage2({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage2> {
  bool _isTermsAgreed = false;
  bool _isPrivacyAgreed = false;
  bool _isMarketingAgreed = false;
  bool _isCheckingOut = false;

  final nameController = TextEditingController();
  late final String foreignKey;

  String? _selectedGift;

  @override
  void initState() {
    super.initState();
    foreignKey = Uuid().v4();
  }

  void _handleCheckout(
    String budget,
    String title,
    String giftSummary,
    String conversationHistory,
  ) async {
    if (!_isTermsAgreed || !_isPrivacyAgreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the terms and privacy policy.'),
        ),
      );
      return;
    }
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in your name.')),
      );
      return;
    }

    setState(() => _isCheckingOut = true);

    try {
      final int amountInCents = (double.parse(budget) * 100).toInt();

      String finalGiftSummary = giftSummary;
      String giftSelection =
          _selectedGift ?? "Surprise me with something else!";

      if (giftSelection != "Surprise me with something else!") {
        finalGiftSummary = "$giftSummary, Gift Selected: $giftSelection";
      }

      final Map<String, dynamic> metadata = {
        'foreignKey': foreignKey,
        'name': nameController.text,
        'giftSummary': finalGiftSummary,
      };

      const int chunkSize = 480;
      for (int i = 0; i * chunkSize < conversationHistory.length; i++) {
        int start = i * chunkSize;
        int end = (i + 1) * chunkSize;
        if (end > conversationHistory.length) {
          end = conversationHistory.length;
        }
        metadata['convo_part_$i'] = conversationHistory.substring(start, end);
      }

      await PaymentService.redirectToCheckout(
        amount: amountInCents,
        currency: 'gbp',
        title: title,
        metadata: metadata,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not proceed to checkout: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isCheckingOut = false);
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Widget buildCartFooter() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Pallete.whiteColor,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: screenWidth - 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    FontAwesomeIcons.instagram,
                    color: Pallete.blackColor,
                    size: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      FontAwesomeIcons.xTwitter,
                      color: Pallete.blackColor,
                      size: 30,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Icon(
                      FontAwesomeIcons.youtube,
                      color: Pallete.blackColor,
                      size: 30,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(
                      FontAwesomeIcons.linkedin,
                      color: Pallete.blackColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FooterLink(
                        text: 'Terms and Conditions',
                        Textcol: Pallete.blackColor,
                        onTap: () => context.push('/terms_and_conditions'),
                      ),
                      FooterLink(
                        text: 'Privacy Policy',
                        Textcol: Pallete.blackColor,
                        onTap: () => context.push('/privacy_policy'),
                      ),
                      FooterLink(
                        text: 'Cookies',
                        Textcol: Pallete.blackColor,
                        onTap: () => context.push('/cookies_policy'),
                      ),
                      FooterLink(
                        text: 'Contact Us',
                        Textcol: Pallete.blackColor,
                        onTap: () => context.push('/contact'),
                      ),
                      FooterLink(
                        text: 'Returns & Refund Policy',
                        Textcol: Pallete.blackColor,
                        onTap: () => context.push('/refund_policy'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGiftChoiceSection(List<String> choices) {
    final displayChoices = List<String>.from(choices);
    if (!displayChoices.contains("Surprise me with something else!")) {
      displayChoices.add("Surprise me with something else!");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
          child: Text(
            'Select your preference from the below options!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Pallete.blackColor,
            ),
          ),
        ),
        ...displayChoices.map((choice) {
          return RadioListTile<String>(
            title: Text(choice),
            value: choice,
            groupValue: _selectedGift,
            onChanged: (String? value) {
              setState(() {
                _selectedGift = value;
              });
            },
            activeColor: Pallete.Purps,
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 800;

    final budgetProvider = Provider.of<BudgetProvider2>(context);
    final budget = budgetProvider.budget;
    final giftSummary = budgetProvider.giftSummary;
    final giftChoices = budgetProvider.giftChoices;
    final conversationHistory = budgetProvider.conversationHistory;

    return BaseLayout(
      appBarColor: Pallete.whiteColor,
      iconColor: Pallete.blackColor,
      appTextColor: Pallete.blackColor,
      centerTitle: true,
      text_title: const Text(
        'Checkout and Payment',
        style: TextStyle(color: Pallete.blackColor),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: screenWidth,
                  height: screenHeight,
                  child: Image.asset(
                    isMobile
                        ? 'assets/images/Cart_Background.png'
                        : 'assets/images/cart_background3.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 140, bottom: 40),
                    child: Container(
                      width: isMobile ? screenWidth * 0.9 : 800,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Your Surprise Profile:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Pallete.blackColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            giftSummary.isNotEmpty
                                ? giftSummary
                                : 'A special surprise tailored just for them.',
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              color: Pallete.blackColor.withOpacity(0.8),
                            ),
                          ),
                          const Divider(height: 30, thickness: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Pallete.blackColor,
                                ),
                              ),
                              Text(
                                "£$budget",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Pallete.blackColor,
                                ),
                              ),
                            ],
                          ),
                          _buildGiftChoiceSection(giftChoices),
                          const SizedBox(height: 20),
                          _buildTextField(
                            "Your Name",
                            controller: nameController,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Checkbox(
                                value: _isTermsAgreed,
                                onChanged:
                                    (bool? value) =>
                                        setState(() => _isTermsAgreed = value!),
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    text: 'I agree to the ',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Terms and Conditions',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer:
                                            TapGestureRecognizer()
                                              ..onTap =
                                                  () => context.push(
                                                    '/terms_and_conditions',
                                                  ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: _isPrivacyAgreed,
                                onChanged:
                                    (bool? value) => setState(
                                      () => _isPrivacyAgreed = value!,
                                    ),
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    text: 'I agree to the ',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Privacy Policy',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer:
                                            TapGestureRecognizer()
                                              ..onTap =
                                                  () => context.push(
                                                    '/privacy_policy',
                                                  ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: _isMarketingAgreed,
                                onChanged:
                                    (bool? value) => setState(
                                      () => _isMarketingAgreed = value!,
                                    ),
                              ),
                              const Expanded(
                                child: Text(
                                  'I\'m happy to receive emails about new products and offers',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () => context.push('/refund_policy'),
                              child: const Text(
                                'Refund Policy',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed:
                                  _isCheckingOut
                                      ? null
                                      : () => _handleCheckout(
                                        budget,
                                        "Surprise Gift",
                                        giftSummary,
                                        conversationHistory,
                                      ),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                backgroundColor: Pallete.Purps,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child:
                                  _isCheckingOut
                                      ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      )
                                      : const Text(
                                        'Proceed to Payment',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // The footer now correctly sits outside the Stack, at the bottom of the page
            buildCartFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hintText, {
    required TextEditingController controller,
    int maxLines = 1,
    int? maxLength,
  }) {
    if (hintText == "Your Email") return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        maxLength: maxLength,
        style: const TextStyle(color: Pallete.blackColor),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Pallete.blackColor.withOpacity(0.6)),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Pallete.Purps, width: 2),
          ),
          counterStyle: TextStyle(color: Pallete.blackColor.withOpacity(0.6)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
