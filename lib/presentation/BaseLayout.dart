import 'package:flutter/material.dart';
import 'package:SandBox_Gifts_Backup/widgets/pallete.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;
  final VoidCallback? onScrollToFAQ;
  final VoidCallback? onScrollToAbout;
  final AppBar? appBarr;
  final Color? appBarColor;
  final Color? appTextColor;
  final Color? iconColor;
  final Text? text_title;
  final bool? centerTitle;

  const BaseLayout({
    super.key,
    required this.child,
    this.onScrollToFAQ,
    this.onScrollToAbout,
    this.appBarr,
    this.appBarColor,
    this.appTextColor,
    this.iconColor,
    this.text_title,
    this.centerTitle,
  });

  Future<bool> _showExitConfirmation(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Confirm Exit'),
                content: const Text(
                  'Are you sure you want to leave this page? \nChat history will not be stored',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false), // Cancel
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true), // Confirm
                    child: const Text('Yes'),
                  ),
                ],
              ),
        ) ??
        false; // Default to false if dialog is dismissed
  }

  Future<void> _handleNavigation(
    BuildContext context,
    VoidCallback action,
  ) async {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    print("Current Route: $currentRoute");
    if (currentRoute == '/startMysteryPage' || currentRoute == '/cart_page') {
      final shouldExit = await _showExitConfirmation(context);
      if (!shouldExit) return; // Cancel navigation if user selects "No"
    }
    action(); // Proceed with the navigation logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor ?? Pallete.TransparentCol,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: centerTitle ?? true,
        title: text_title,
        leading: IconButton(
          icon: Icon(Icons.home, color: iconColor ?? Pallete.MainTextCol),
          onPressed:
              () => _handleNavigation(
                context,
                () => Navigator.of(context).pushNamed('/home'),
              ),
        ),
        actions: [
          Builder(
            builder:
                (context) => IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: appTextColor ?? Pallete.MainTextCol,
                  ),
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
              child: const Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap:
                  () => _handleNavigation(
                    context,
                    () => Navigator.of(
                      context,
                    ).pushNamed('/home', arguments: {'scrollTo': 'about'}),
                  ),
            ),
            ListTile(
              leading: const Icon(Icons.question_answer),
              title: const Text('Frequently Asked Questions'),
              onTap:
                  () => _handleNavigation(
                    context,
                    () => Navigator.of(
                      context,
                    ).pushNamed('/home', arguments: {'scrollTo': 'faq'}),
                  ),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Contact Us'),
              onTap:
                  () => _handleNavigation(
                    context,
                    () => Navigator.of(context).pushNamed('/contact'),
                  ),
            ),
          ],
        ),
      ),
      body: child,
    );
  }
}
