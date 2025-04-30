// lib/presentation/widgets/base_layout.dart
import 'package:SandBox_Gifts_Backup/footer.dart';
import 'package:SandBox_Gifts_Backup/presentation/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:SandBox_Gifts_Backup/presentation/widgets/pallete.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;
  final Widget? floatingActionButton;

  const BaseLayout({super.key, required this.child, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: Pallete.gradientBackground, // Use the LinearGradient directly
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Pallete.TransparentCol,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.shopping_cart, color: Pallete.MainTextCol),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => const CartPage()));
              // TODO: Replace with actual CartPage navigation
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Go to CartPage')));
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
            padding: EdgeInsets.zero,
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
                  Navigator.pop(context);
                  // Add navigation here
                },
              ),
              ListTile(
                leading: Icon(Icons.question_answer),
                title: Text('Frequently Asked Questions'),
                onTap: () {
                  Navigator.pop(context);
                  // Add navigation here
                },
              ),

              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Contact Us'),
                onTap: () {
                  Navigator.pop(context);
                  // Add navigation here
                },
              ),
            ],
          ),
        ),
        body: child,
        floatingActionButton: floatingActionButton,
        // Provide the required 'height' parameter
      ),
    );
  }
}
