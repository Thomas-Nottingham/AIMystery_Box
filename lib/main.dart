import 'package:SandBox_Gifts_Backup/global_variables.dart';
import 'package:SandBox_Gifts_Backup/pages/MyHomePage.dart';
import 'package:SandBox_Gifts_Backup/pages/product_details_page.dart';
import 'package:SandBox_Gifts_Backup/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:SandBox_Gifts_Backup/pages/StartMysteryPage.dart';

void main() {
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
          scaffoldBackgroundColor: Colors.black,
          
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 0, 0), brightness: Brightness.dark,).copyWith(
      primary: const Color(0xFF00FF9C), // Replace with your desired color
      secondary: const Color(0xFFA100FF),
        ),
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 16,
              color: Colors.white70, // helps hint text show on dark bg

            ),
            prefixIconColor: Color.fromRGBO(119,119,119,1),
          ),
      
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent, // Or black if you prefer solid
            elevation: 0,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
            iconTheme: IconThemeData(color: Colors.white),

          textTheme: TextTheme(
            titleLarge: 
            TextStyle(fontWeight: FontWeight.bold, fontSize: 35
            , color: Colors.white,),
            
      
            titleMedium:  GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white
            ),
            bodySmall: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white70, // helps hint text show on dark bg
            ),
      
            titleSmall: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: Colors.white60, // helps hint text show on dark bg
            )
      
            
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

