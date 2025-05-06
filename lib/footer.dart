import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:SandBox_Gifts_Backup/widgets/pallete.dart';

class MyFooter extends StatelessWidget {
  const MyFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 700;
    return Container(
      color: Pallete.TransparentCol,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Align items to the start
              children: const [
                // Instagram Icon
                // Add horizontal spacing
                Icon(
                  FontAwesomeIcons.instagram,
                  color: Pallete.footerCol,
                  size: 30, // Slightly larger size for better visibility
                ),

                // Twitter Icon
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ), // Add horizontal spacing
                  child: Icon(
                    FontAwesomeIcons.xTwitter,
                    color: Pallete.footerCol,
                    size: 30,
                  ),
                ),
                // YouTube Icon
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ), // Add horizontal spacing
                  child: Icon(
                    FontAwesomeIcons.youtube,
                    color: Pallete.footerCol,
                    size: 30,
                  ),
                ),
                // LinkedIn Icon
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ), // Add horizontal spacing
                  child: Icon(
                    FontAwesomeIcons.linkedin,
                    color: Pallete.footerCol,
                    size: 30,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // Space between icons and text
            // Remove Expanded – it conflicts with horizontal scroll
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    FooterLink(text: 'Terms and conditions'),
                    FooterLink(text: 'Privacy Policy'),
                    FooterLink(text: 'Product purchase and use agreement'),
                    FooterLink(text: 'Contact Us'),
                    FooterLink(text: 'Returns & Refund Policy'),
                    FooterLink(text: 'AI Disclosure'),
                  ],
                ),
                SizedBox(width: isMobile ? 80 : 250), // Space between columns
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    FooterLink(text: 'About Us'),
                    FooterLink(text: 'Order Tracking'),
                    FooterLink(text: 'Cookie Policy'),
                    FooterLink(text: 'Affiliate Disclosure '),
                    FooterLink(text: 'Shipping Policy'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FooterLink extends StatelessWidget {
  final String text;
  const FooterLink({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 700;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(
        child: Text(
          text,
          style: TextStyle(
            color: Pallete.footerCol,
            fontSize: isMobile ? 12 : 20,
          ),
          softWrap: true,
        ),
      ),
    );
  }
}
