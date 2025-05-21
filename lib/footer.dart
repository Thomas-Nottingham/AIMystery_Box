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
            isMobile
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FooterLink(
                          text: 'Terms and conditions',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/terms_and_conditions',
                              ),
                        ),
                        FooterLink(
                          text: 'Privacy Policy',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/privacy_policy',
                              ),
                        ),
                        FooterLink(
                          text: 'Cookies Policy',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/cookies_policy',
                              ),
                        ),
                        FooterLink(
                          text: 'Contact Us',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/privacy_policy',
                              ),
                        ),
                        FooterLink(
                          text: 'Returns & Refund Policy',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/privacy_policy',
                              ),
                        ),
                        FooterLink(
                          text: 'AI Disclosure',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/privacy_policy',
                              ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FooterLink(
                          text: 'About Us',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/privacy_policy',
                              ),
                        ),
                        FooterLink(
                          text: 'Order Tracking',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/privacy_policy',
                              ),
                        ),
                        FooterLink(
                          text: 'Cookie Policy',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/privacy_policy',
                              ),
                        ),
                        FooterLink(
                          text: 'Affiliate Disclosure',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/privacy_policy',
                              ),
                        ),
                        FooterLink(
                          text: 'Shipping Policy',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/privacy_policy',
                              ),
                        ),
                      ],
                    ),
                  ],
                )
                : Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FooterLink(
                          text: 'Terms and conditions',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/terms_and_conditions',
                              ),
                        ),
                        FooterLink(
                          text: 'Privacy Policy',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/privacy_policy',
                              ),
                        ),
                        FooterLink(
                          text: 'Cookies Policy',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/cookies_policy',
                              ),
                        ),
                        FooterLink(
                          text: 'Contact Us',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/privacy_policy',
                              ),
                        ),
                        FooterLink(
                          text: 'Returns & Refund Policy',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/privacy_policy',
                              ),
                        ),
                        FooterLink(
                          text: 'AI Disclosure',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/privacy_policy',
                              ),
                        ),
                      ],
                    ),
                    SizedBox(width: 250),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FooterLink(
                          text: 'About Us',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/privacy_policy',
                              ),
                        ),
                        FooterLink(
                          text: 'Order Tracking',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/privacy_policy',
                              ),
                        ),
                        FooterLink(
                          text: 'Cookie Policy',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/privacy_policy',
                              ),
                        ),
                        FooterLink(
                          text: 'Affiliate Disclosure',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/privacy_policy',
                              ),
                        ),
                        FooterLink(
                          text: 'Shipping Policy',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/privacy_policy',
                              ),
                        ),
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
  final VoidCallback onTap;

  const FooterLink({
    super.key,
    required this.text,
    this.Textcol,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 700;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: MouseRegion(
        cursor: SystemMouseCursors.click, // 👈 Changes cursor on hover
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            text,
            style: TextStyle(
              color: Textcol ?? Pallete.footerCol,
              fontSize: isMobile ? 12 : 20,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
}
