import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:SandBox_Gifts_Backup/presentation/BaseLayout.dart';
import 'package:SandBox_Gifts_Backup/providers/cart_provider.dart';
import 'package:SandBox_Gifts_Backup/widgets/pallete.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:SandBox_Gifts_Backup/footer.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isTermsAgreed = false;
  bool _isPrivacyAgreed = false;
  bool _isMarketingAgreed = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  void _handleCheckout() {
    if (_isTermsAgreed && _isPrivacyAgreed) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Processing payment...')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please agree to the terms and privacy policy.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Widget buildCartFooter() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 700;
    return Container(
      color: Pallete.whiteColor,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: screenWidth - 40,
          ), // Ensure it spans the screen width
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center column content
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center icons
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
              SizedBox(height: 20), // Space between icons and text
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center text columns
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      FooterLink(
                        text: 'Terms and Conditions',
                        Textcol: Pallete.blackColor,
                      ),
                      FooterLink(
                        text: 'Privacy Policy',
                        Textcol: Pallete.blackColor,
                      ),
                      FooterLink(
                        text: 'Product purchase and use agreement',
                        Textcol: Pallete.blackColor,
                      ),
                      FooterLink(
                        text: 'Contact Us',
                        Textcol: Pallete.blackColor,
                      ),
                      FooterLink(
                        text: 'Returns & Refund Policy',
                        Textcol: Pallete.blackColor,
                      ),
                      FooterLink(
                        text: 'AI Disclosure',
                        Textcol: Pallete.blackColor,
                      ),
                    ],
                  ),
                  SizedBox(width: isMobile ? 80 : 250), // Space between columns
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      FooterLink(text: 'About Us', Textcol: Pallete.blackColor),
                      FooterLink(
                        text: 'Order Tracking',
                        Textcol: Pallete.blackColor,
                      ),
                      FooterLink(
                        text: 'Cookie Policy',
                        Textcol: Pallete.blackColor,
                      ),
                      FooterLink(
                        text: 'Affiliate Disclosure ',
                        Textcol: Pallete.blackColor,
                      ),
                      FooterLink(
                        text: 'Shipping Policy',
                        Textcol: Pallete.blackColor,
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 800;
    final cart = Provider.of<CartProvider>(context).cart;

    return BaseLayout(
      appBarColor: Pallete.whiteColor,
      iconColor: Pallete.blackColor,
      appTextColor: Pallete.blackColor,
      centerTitle: true,
      text_title: Text(
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
                    padding: const EdgeInsets.only(top: 140),
                    child: Container(
                      width: isMobile ? screenWidth * 0.9 : 800,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Summary',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Pallete.blackColor,
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Pallete.blackColor,
                                ),
                              ),
                              Text(
                                '£10',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Pallete.blackColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          _buildTextField(
                            "Your Name",
                            controller: nameController,
                          ),
                          _buildTextField(
                            "Your Email",
                            controller: emailController,
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Checkbox(
                                value: _isTermsAgreed,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isTermsAgreed = value!;
                                  });
                                },
                                activeColor: Colors.blue,
                              ),

                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    text: 'I agree to the ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Terms and Conditions',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer:
                                            TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.pushNamed(
                                                  context,
                                                  '/home',
                                                );
                                              },
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
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isPrivacyAgreed = value!;
                                  });
                                },
                                activeColor: Colors.blue,
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    text: 'I agree to the ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Privacy Policy',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer:
                                            TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.pushNamed(
                                                  context,
                                                  '/home',
                                                );
                                              },
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
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isMarketingAgreed = value!;
                                  });
                                },
                                activeColor: Colors.blue,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    'I\'m happy to receive emails about new products and offers',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Refund Policy',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _handleCheckout,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                backgroundColor: Pallete.Purps,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
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
    bool showCounter = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        maxLength: maxLength,
        style: TextStyle(color: Pallete.blackColor),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Pallete.blackColor.withOpacity(0.6)),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Pallete.Purps, width: 2),
          ),
          counterStyle: TextStyle(color: Pallete.blackColor.withOpacity(0.6)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
