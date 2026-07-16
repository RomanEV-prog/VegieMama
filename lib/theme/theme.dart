import 'package:flutter/material.dart';

const Color mintGreen = Color(0xFF70C178);
const Color peach = Color(0xFFFFE0B2);
const Color lavender = Color(0xFFE1BEE7);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: mintGreen,
  scaffoldBackgroundColor: peach,
  colorScheme: ColorScheme.light(
    primary: mintGreen,
    secondary: lavender,
    background: peach,
  ),
  cardColor: lavender.withOpacity(0.15),
  appBarTheme: const AppBarTheme(
    backgroundColor: mintGreen,
    foregroundColor: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
    ),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
    headlineMedium: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontFamily: 'Roboto'),
    bodyMedium: TextStyle(fontFamily: 'Roboto'),
  ),
  fontFamily: 'Roboto',
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: mintGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      textStyle: const TextStyle(fontFamily: 'Poppins'),
    ),
  ),
  cardTheme: CardTheme(
    color: lavender.withOpacity(0.15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: peach,
    selectedItemColor: mintGreen,
    unselectedItemColor: lavender,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: mintGreen,
  scaffoldBackgroundColor: Colors.grey[900],
  colorScheme: ColorScheme.dark(
    primary: mintGreen,
    secondary: lavender,
    background: Colors.grey[900]!,
  ),
  cardColor: lavender.withOpacity(0.25),
  appBarTheme: const AppBarTheme(
    backgroundColor: mintGreen,
    foregroundColor: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
    ),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
    headlineMedium: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontFamily: 'Roboto'),
    bodyMedium: TextStyle(fontFamily: 'Roboto'),
  ),
  fontFamily: 'Roboto',
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: mintGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      textStyle: const TextStyle(fontFamily: 'Poppins'),
    ),
  ),
  cardTheme: CardTheme(
    color: lavender.withOpacity(0.25),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: mintGreen,
    unselectedItemColor: lavender,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),
); 