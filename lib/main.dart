import 'package:SandBox_Gifts_Backup/pages/Contact_us.dart';
import 'package:SandBox_Gifts_Backup/pages/StartMysteryPage.dart';
import 'package:SandBox_Gifts_Backup/pages/cart_page.dart';
import 'package:SandBox_Gifts_Backup/pages/cookie_policy.dart';
import 'package:SandBox_Gifts_Backup/pages/privacy_policy_page.dart';
import 'package:SandBox_Gifts_Backup/pages/product_list.dart';
import 'package:SandBox_Gifts_Backup/pages/terms_and_conditions.dart';
import 'package:SandBox_Gifts_Backup/secrets.dart';
import 'package:SandBox_Gifts_Backup/widgets/pallete.dart';

import 'package:SandBox_Gifts_Backup/providers/cart_provider.dart';
import 'package:SandBox_Gifts_Backup/supabase_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/budget_provider.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings();
  await initializeSupabase();
  usePathUrlStrategy();
  runApp(
    ChangeNotifierProvider(
      create: (_) => BudgetProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'The Gift Vaults',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Pallete.gradientBackground.colors.first,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Pallete.ScaffoldBackgroundColor,
            brightness: Brightness.light,
          ).copyWith(
            primary: Pallete.primaryCol,
            secondary: Pallete.secondaryCol,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Pallete.TransparentCol,
            elevation: 0,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Pallete.MainTextCol,
            ),
          ),
          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: Pallete.MainTextCol,
            ),
            titleMedium: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Pallete.MainTextCol,
            ),
            bodySmall: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Pallete.hintTextCol,
            ),
            titleSmall: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: Pallete.MainTextCol,
            ),
          ),
          useMaterial3: true,
        ),
        initialRoute: '/home',
        onGenerateRoute: (settings) {
          if (settings.name == '/startMysteryPage') {
            return MaterialPageRoute(
              builder: (_) => StartMysteryPage(),
              settings: settings,
            );
          }
          return null;
        },
        routes: {
          '/home': (context) => const ProductList(),
          '/startMysteryPage': (context) => StartMysteryPage(),
          '/contact': (context) => const ContactUs(),
          '/cart_page': (context) => const CartPage(),
          '/privacy_policy': (context) => const PrivacyPolicyPage(),
          '/terms_and_conditions': (context) => const TermsAndConditionsPage(),
          '/cookies_policy': (context) => const CookiePolicyPage(),

          // Navigate to StartMysteryPage with the AI response
        },
      ),
    );
  }
}
