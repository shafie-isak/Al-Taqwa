import 'package:flutter/material.dart';

// Light Theme Colors
const Color lightPrimaryColor = Color(0xFF072D4C);
const Color lightSecondaryColor = Color(0xFFEC8A00);
const Color lightBackgroundColor = Color(0xFFE3F2FF);
const Color lightCardColor = Color(0xFFC3E2FC);
const Color lightTextColor = Color(0xFF072D4C);

// Dark Theme Colors
const Color darkPrimaryColor = Color(0xFF1F2633);
const Color darkSecondaryColor = Color(0xFFEC8A00);
const Color darkBackgroundColor = Color(0xFF121212);
const Color darkCardColor = Color(0xFF1E1E1E);
const Color darkTextColor = Color(0xFFFFFFFF);


class Themes {
  // Light Theme
  static final light = ThemeData(
    primaryColor: lightPrimaryColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBackgroundColor,
    cardColor: lightCardColor,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: lightTextColor),
      bodyMedium: TextStyle(color: lightTextColor),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: lightPrimaryColor,
      foregroundColor: lightTextColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: lightTextColor, backgroundColor: lightSecondaryColor,
      ),
    ),
  );



  static final dark = ThemeData(
    primaryColor: darkPrimaryColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackgroundColor,
    cardColor: darkCardColor,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: darkTextColor),
      bodyMedium: TextStyle(color: darkTextColor),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkPrimaryColor,
      foregroundColor: darkTextColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: darkTextColor, backgroundColor: darkSecondaryColor,
      ),
    ),
  );
}


