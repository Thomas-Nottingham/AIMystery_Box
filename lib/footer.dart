import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:SandBox_Gifts_Backup/widgets/pallete.dart';
import 'package:go_router/go_router.dart';

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
                          onTap: () => context.push('/terms_and_conditions'),
                        ),

                        FooterLink(
                          text: 'Privacy Policy',
                          onTap: () => context.push('/privacy_policy'),
                        ),
                        FooterLink(
                          text: 'Cookies Policy',
                          onTap: () => context.push('/cookies_policy'),
                        ),
                        FooterLink(
                          text: 'Contact Us',
                          onTap: () => context.push('/contact'),
                        ),
                        FooterLink(
                          text: 'Returns & Refund Policy',
                          onTap: () => context.push('/refund_policy'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                )
                : Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FooterLink(
                          text: 'Terms and conditions',
                          onTap: () => context.push('/terms_and_conditions'),
                        ),
                        FooterLink(
                          text: 'Privacy Policy',
                          onTap: () => context.push('/privacy_policy'),
                        ),
                        FooterLink(
                          text: 'Cookies Policy',
                          onTap: () => context.push('/cookies_policy'),
                        ),
                        FooterLink(
                          text: 'Contact Us',
                          onTap: () => context.push('/contact'),
                        ),
                        FooterLink(
                          text: 'Returns & Refund Policy',
                          onTap: () => context.push('/refund_policy'),
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
            ),
          ),
        ),
      ),
    );
  }
}
