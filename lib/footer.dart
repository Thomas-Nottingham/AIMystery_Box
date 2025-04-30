import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:SandBox_Gifts_Backup/presentation/widgets/pallete.dart';

class MyFooter extends StatelessWidget {
  const MyFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pallete.TransparentCol,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(FontAwesomeIcons.instagram, color: Colors.white, size: 20),
                SizedBox(height: 12),
                Icon(FontAwesomeIcons.xTwitter, color: Colors.white, size: 20),
                SizedBox(height: 12),
                Icon(FontAwesomeIcons.youtube, color: Colors.white, size: 20),
                SizedBox(height: 12),
                Icon(FontAwesomeIcons.linkedin, color: Colors.white, size: 20),
              ],
            ),
            const SizedBox(width: 30),
            // Remove Expanded – it conflicts with horizontal scroll
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(
        width: 200, // Set a fixed or relative width
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          softWrap: true,
        ),
      ),
    );
  }
}
