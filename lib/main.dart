import 'package:SandBox_Gifts_Backup/pages/MyHomePage.dart';
import 'package:SandBox_Gifts_Backup/widgets/pallete.dart';
import 'package:SandBox_Gifts_Backup/providers/cart_provider.dart';
import 'package:SandBox_Gifts_Backup/supabase_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeSupabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Shopping App', // Keep this as a plain string for system use
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor:
              Pallete
                  .gradientBackground
                  .colors
                  .first, // Use the first color of the gradient, // Replace with a valid color

          colorScheme: ColorScheme.fromSeed(
            seedColor: Pallete.ScaffoldBackgroundColor,
            brightness: Brightness.light,
          ).copyWith(
            primary: Pallete.primaryCol, // Replace with your desired color
            secondary: Pallete.secondaryCol,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Pallete.hintTextCol, // helps hint text show on dark bg
            ),
            prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
          ),

          appBarTheme: const AppBarTheme(
            backgroundColor:
                Pallete.TransparentCol, // Or black if you prefer solid
            elevation: 0,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Pallete.MainTextCol,
            ),
          ),
          iconTheme: IconThemeData(color: Pallete.MainTextCol),

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
              color: Pallete.hintTextCol, // helps hint text show on dark bg
            ),

            titleSmall: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: Pallete.MainTextCol, // helps hint text show on dark bg
            ),
          ),
          useMaterial3: true,
        ),
        //home: ProductDetailsPage(product: products[0],),
        //home: StartMysteryPage(product: products[0],),
        home: HomePage(),
      ),
    );
  }
}
