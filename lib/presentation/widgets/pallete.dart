import 'package:flutter/material.dart';

class Pallete {
  static const Color mainFontColor = Color.fromRGBO(19, 61, 95, 1);
  static const Color firstSuggestionBoxColor = Color.fromRGBO(165, 231, 244, 1);
  static const Color secondSuggestionBoxColor = Color.fromRGBO(
    157,
    202,
    235,
    1,
  );
  static const Color thirdSuggestionBoxColor = Color.fromRGBO(162, 238, 239, 1);
  static const Color assistantCircleColor = Color.fromRGBO(209, 243, 249, 1);
  static const Color borderColor = Color.fromRGBO(200, 200, 200, 1);
  static const Color blackColor = Colors.black;
  static const Color whiteColor = Colors.white;
  static const Color exoticYellow = Colors.amberAccent;
  static const Color exoticPurple = Colors.deepPurpleAccent;
  static const Color exoticRed = Colors.deepOrange;
  static const Color exoticPurple2 = Colors.purpleAccent;
  // static const Color chatGptColor = Color(0xFF0FF0FC);
  // static const Color dallEColor = Color(0xFF9C00FF);     // Electric Purple
  // static const Color voiceAssistantColor = Color(0xFFFF4EF1); // Hot Pink
  static const Color chatGptColor = Color(0xFFFF9A8B); // Coral
  static const Color dallEColor = Color(0xFFF6CD61); // Soft Yellow
  static const Color voiceAssistantColor = Color(0xFFB8E986);
  // static const Color chatGptColor = Color(0xFF5DADE2);   // Sky Blue
  // static const Color dallEColor = Color(0xFFA569BD);     // Lavender Purple
  // static const Color voiceAssistantColor = Color(0xFF48C9B0); // Teal
  // static const Color chatGptColor = Color(0xFF66FCF1);   // Cool Mint
  // static const Color dallEColor = Color(0xFFC5C6C7);     // Silvery Grey
  // static const Color voiceAssistantColor = Color(0xFF45A29E); // Desaturated Teal
  static const Color micButtonColor = Color(0xFF2C3E50); // Midnight Blue
  static const Color micButtonColor2 = Color(0xFF8B5E3C);

  //colors i was using before
  // static const Color ScaffoldBackgroundColor = Colors.black;
  // static const Color primaryCol = Color(0xFF00FF9C);
  // static const Color secondaryCol = Color(0xFFA100FF);
  // static const Color YellowCol = Colors.amberAccent;
  // static const Color hintTextCol = Colors.white70;
  // static const Color TransparentCol = Colors.transparent;
  // static const Color MainTextCol = Colors.white;
  // static const Color MysteryTitle = Color.fromARGB(201, 238, 255, 0);

  // static const Color ScaffoldBackgroundColor = Color(
  //   0xFFF4F5DC,
  // ); // Soft cream background
  // static const Color primaryCol = Color(
  //   0xFFD0BE8F,
  // ); // Warm sand tone, good for buttons or highlights
  // static const Color secondaryCol = Color(
  //   0xFFB8BE86,
  // ); // Light olive, secondary buttons or accents
  // static const Color YellowCol = Color(
  //   0xFFD0BE8F,
  // ); // Reusing warm sand as yellow equivalent
  // static const Color hintTextCol = Color(
  //   0xFF67633B,
  // ); // Earthy muted green, soft on eyes
  // static const Color TransparentCol = Colors.transparent;
  // static const Color MainTextCol = Color(
  //   0xFF6A5D3E,
  // ); // Deep olive for legible main text
  // static const Color MysteryTitle = Color(0xFFB8BE86);

  // button color for begin game 0xFF261532

  static const Color ScaffoldBackgroundColor = Color(
    0xFF577E89,
  ); // Hampton - soft light cream, very gentle background

  static const Color primaryCol = Color(
    0xFFD6C8DF,
  ); // Harvest Gold - warm inviting orange, for buttons/highlights

  static const Color secondaryCol = Color(0xFF261532);
  // Calico - muted sandy yellow, for secondary elements

  static const Color Purps = Color(0xFF65558F);
  // Reusing Calico as the yellow equivalent

  static const Color hintTextCol = Color(0xFFB3B3B3);
  // Sea Nymph - soft teal, relaxing for hint text

  static const Color TransparentCol = Colors.transparent;

  static const Color MainTextCol = Color(0xFFFEF7FF);
  // Smalt Blue - strong muted blue for main readable text

  static const Color MysteryTitle = Color(0xFFD6C8DF);

  static const LinearGradient gradientBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.07, 0.18, 0.37, 0.42, 0.63, 0.80, 0.90],
    colors: [
      Color(0xFF040120),
      Color(0xFF1B52C2),
      Color(0xFF9614E0),
      Color(0xFF0E0230),
      Color(0xFF6B1ABF),
      Color(0xFF661494),
      Color(0xFF3F209E),
    ],
  );
  // Smalt Blue - same strong muted blue for the mystery title
} // Also Sea Nymph - adds some mystery feel
