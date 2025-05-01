// lib/presentation/widgets/base_layout.dart
import 'package:SandBox_Gifts_Backup/footer.dart';
import 'package:SandBox_Gifts_Backup/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:SandBox_Gifts_Backup/widgets/pallete.dart';
import 'package:SandBox_Gifts_Backup/widgets/product_list.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;
  final Widget? floatingActionButton;
  final VoidCallback? onScrollToFAQ; // Add a callback for scrolling to FAQ
  final VoidCallback? onScrollToAbout; // Add a callback for scrolling to About

  const BaseLayout({
    super.key,
    required this.child,
    this.floatingActionButton,
    this.onScrollToFAQ,
    this.onScrollToAbout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.TransparentCol,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.home, color: Pallete.MainTextCol),
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => const CartPage()));
          },
        ),
        actions: [
          Builder(
            builder:
                (context) => IconButton(
                  icon: Icon(Icons.menu, color: Pallete.MainTextCol),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Pallete.primaryCol),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                onScrollToAbout?.call();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text('Frequently Asked Questions'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                onScrollToFAQ?.call(); // Trigger the callback
              },
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: child,
      floatingActionButton: floatingActionButton,
    );
  }
}
