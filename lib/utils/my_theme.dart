import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData light = ThemeData(
      colorScheme: const ColorScheme(
        background: Colors.white,
        onBackground: Colors.black,
        primary: Color(0xff1E7F6D),
        onPrimary: Colors.black,
        secondary: Color(0xffFACB62),
        onSecondary: Colors.black,
        brightness: Brightness.light,
        error: Colors.red,
        onError: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
      textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)));

  static ThemeData dark = ThemeData(
      colorScheme: ColorScheme(
        background: const Color(0xff121212),
        onBackground: Colors.white,
        primary: const Color(0xff1E7F6D),
        onPrimary: Colors.black,
        secondary: Colors.white.withOpacity(0.07),
        onSecondary: Colors.black,
        brightness: Brightness.light,
        error: Colors.red,
        onError: Colors.black,
        surface: Colors.white.withOpacity(0.07),
        onSurface: Colors.black,
      ),
      textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)));
}
