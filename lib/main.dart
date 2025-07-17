import 'package:SandBox_Gifts_Backup/pages/Contact_us.dart';
import 'package:SandBox_Gifts_Backup/pages/StartMysteryPage.dart';
import 'package:SandBox_Gifts_Backup/pages/cart_page.dart';
import 'package:SandBox_Gifts_Backup/pages/cookie_policy.dart';
import 'package:SandBox_Gifts_Backup/pages/privacy_policy_page.dart';
import 'package:SandBox_Gifts_Backup/pages/product_list.dart';
import 'package:SandBox_Gifts_Backup/pages/refund_policy.dart';
import 'package:SandBox_Gifts_Backup/pages/success_page.dart';
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
import 'package:go_router/go_router.dart';
import 'package:SandBox_Gifts_Backup/core/Ai/openai_serviceV2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeSupabase();
  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings();

  usePathUrlStrategy();

  // --- CREATE A SINGLE SHARED INSTANCE OF THE SERVICE ---
  final openAIService = OpenAIService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BudgetProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        // --- PROVIDE THAT SINGLE INSTANCE TO THE ENTIRE APP ---
        Provider.value(value: openAIService),
      ],
      child: const MyApp(),
    ),
  );
}

// Your GoRouter and MyApp class remain the same.
final _router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) {
        final scrollTo = state.uri.queryParameters['scrollTo'];
        return ProductList(scrollTo: scrollTo);
      },
    ),
    GoRoute(
      path: '/startMysteryPage',
      builder: (_, __) => const StartMysteryPage(),
    ),
    GoRoute(path: '/contact', builder: (_, __) => const ContactUs()),
    GoRoute(path: '/cart_page', builder: (_, __) => const CartPage()),
    GoRoute(
      path: '/privacy_policy',
      builder: (_, __) => const PrivacyPolicyPage(),
    ),
    GoRoute(
      path: '/terms_and_conditions',
      builder: (_, __) => const TermsAndConditionsPage(),
    ),
    GoRoute(
      path: '/cookies_policy',
      builder: (_, __) => const CookiePolicyPage(),
    ),
    GoRoute(
      path: '/refund_policy',
      builder: (_, __) => const ReturnPolicyPage(),
    ),
    GoRoute(
      path: '/success',
      builder: (context, state) {
        // Extract the session_id from the URL and pass it to the page
        final sessionId = state.uri.queryParameters['session_id'] ?? '';
        return SuccessPage(sessionId: sessionId);
      },
    ),
    GoRoute(
      path: '/cancel',
      builder:
          (_, __) =>
              const Scaffold(body: Center(child: Text("Payment Canceled."))),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
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
    );
  }
}
