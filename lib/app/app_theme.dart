import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightThemeData => ThemeData(
    colorSchemeSeed: AppColors.themeColor,
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: _inputDecorationTheme,
    filledButtonTheme: _filledButtonTheme,
    textTheme: TextTheme(
      // Headlines like "Welcome Back", "Enter OTP Code"
      headlineLarge: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),

      // Body / subtitle text like "Please Enter Your Email Address"
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.black54,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleMedium: TextStyle(fontSize: 22),
    ),
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  static ThemeData get darkThemeData => ThemeData(
    colorSchemeSeed: AppColors.themeColor,
    brightness: Brightness.dark,
  );

  static InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    hintStyle: const TextStyle(fontWeight: FontWeight.w300),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.themeColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.themeColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.themeColor),
    ),
  );

  static FilledButtonThemeData get _filledButtonTheme => FilledButtonThemeData(
    style: FilledButton.styleFrom(
      fixedSize: Size.fromWidth(double.maxFinite),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      textStyle: TextStyle(fontSize: 16, color: Colors.white),
      backgroundColor: AppColors.themeColor,
    ),
  );
}
