import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:SandBox_Gifts_Backup/widgets/pallete.dart';

class MyFooter extends StatelessWidget {
  final Color? footerCol;
  final Color? Textcol;

  const MyFooter({super.key, this.footerCol, this.Textcol});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 700;
    return Container(
      color: footerCol ?? Pallete.TransparentCol,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Use Wrap for icons to prevent overflow on mobile
            Wrap(
              spacing: isMobile ? 16 : 24,
              runSpacing: 12,
              children: [
                Icon(
                  FontAwesomeIcons.instagram,
                  color: Pallete.footerCol,
                  size: isMobile ? 22 : 30,
                ),
                Icon(
                  FontAwesomeIcons.xTwitter,
                  color: Pallete.footerCol,
                  size: isMobile ? 22 : 30,
                ),
                Icon(
                  FontAwesomeIcons.youtube,
                  color: Pallete.footerCol,
                  size: isMobile ? 22 : 30,
                ),
                Icon(
                  FontAwesomeIcons.linkedin,
                  color: Pallete.footerCol,
                  size: isMobile ? 22 : 30,
                ),
              ],
            ),
            SizedBox(height: 20),
            // Stack columns vertically on mobile
            isMobile
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        FooterLink(text: 'About Us'),
                        FooterLink(text: 'Order Tracking'),
                        FooterLink(text: 'Cookie Policy'),
                        FooterLink(text: 'Affiliate Disclosure '),
                        FooterLink(text: 'Shipping Policy'),
                      ],
                    ),
                  ],
                )
                : Row(
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
                    SizedBox(width: 250),
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
  final Color? Textcol;
  const FooterLink({super.key, required this.text, this.Textcol});

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
            color: Textcol ?? Pallete.footerCol,
            fontSize: isMobile ? 12 : 20,
          ),
          softWrap: true,
        ),
      ),
    );
  }
}
