import 'package:flutter/material.dart';

/// Text theme definitions for VeggieMama
class AppTextTheme {
  AppTextTheme._();

  static const TextTheme textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 28,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      fontSize: 22,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      fontSize: 18,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 12,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
  );
}
