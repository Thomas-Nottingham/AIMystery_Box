import 'package:flutter/material.dart';
import 'package:SandBox_Gifts_Backup/widgets/pallete.dart';
import 'package:go_router/go_router.dart';

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

  // This function now correctly returns true/false without navigating
  Future<bool> _showExitConfirmation(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder:
              (dialogContext) => AlertDialog(
                title: const Text('Confirm Exit'),
                content: const Text(
                  'Are you sure you want to leave this page? \nChat history will not be stored',
                ),
                actions: [
                  TextButton(
                    onPressed:
                        () => Navigator.of(dialogContext).pop(false), // Cancel
                    child: const Text('No'),
                  ),
                  TextButton(
                    // ## THIS IS THE ONLY LINE THAT WAS CHANGED ##
                    onPressed:
                        () => Navigator.of(dialogContext).pop(true), // Confirm
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
    // This uses the old route detection, which you said works for the pop-up
    final currentRoute = ModalRoute.of(context)?.settings.name;

    if (currentRoute == '/startMysteryPage' || currentRoute == '/cart_page') {
      final shouldExit = await _showExitConfirmation(context);
      if (!shouldExit) {
        return; // User clicked "No," so we stop here.
      }
    }

    // Close the drawer if it is open before navigating
    if (Scaffold.of(context).isEndDrawerOpen) {
      Navigator.of(context).pop();
    }

    action(); // Proceed with the intended navigation (e.g., to /contact)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor ?? Pallete.TransparentCol,
        elevation: 0,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        centerTitle: centerTitle ?? true,
        title: text_title,
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
        child: Builder(
          builder: (drawerContext) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Pallete.primaryCol),
                  child: const Text(
                    'Menu',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap:
                      () => _handleNavigation(
                        drawerContext,
                        () => context.push('/home'),
                      ),
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('About'),
                  onTap:
                      () => _handleNavigation(
                        drawerContext,
                        () => context.push('/home?scrollTo=about'),
                      ),
                ),
                ListTile(
                  leading: const Icon(Icons.question_answer),
                  title: const Text('Frequently Asked Questions'),
                  onTap:
                      () => _handleNavigation(
                        drawerContext,
                        () => context.push('/home?scrollTo=faq'),
                      ),
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Contact Us'),
                  onTap:
                      () => _handleNavigation(
                        drawerContext,
                        () => context.push('/contact'),
                      ),
                ),
              ],
            );
          },
        ),
      ),
      body: child,
    );
  }
}
