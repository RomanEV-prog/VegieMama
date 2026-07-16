import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_radius.dart';
import 'app_color_scheme.dart';
import 'app_text_theme.dart';

/// Assembled light and dark ThemeData for VeggieMama
class AppTheme {
  AppTheme._();

  static ThemeData get light => _buildTheme(AppColorScheme.light);
  static ThemeData get dark => _buildTheme(AppColorScheme.dark);

  static ThemeData _buildTheme(ColorScheme colorScheme) {
    final bool isDark = colorScheme.brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      primaryColor: AppColors.mintGreen,
      scaffoldBackgroundColor:
          isDark ? colorScheme.surface : AppColors.peach,
      fontFamily: 'Roboto',
      textTheme: AppTextTheme.textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.mintGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.appBarRadius,
        ),
      ),
      cardTheme: CardTheme(
        color: isDark
            ? AppColors.lavender.withValues(alpha: 0.25)
            : AppColors.lavender.withValues(alpha: 0.15),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.cardRadius,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mintGreen,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.buttonRadius,
          ),
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDark ? Colors.black : AppColors.peach,
        selectedItemColor: AppColors.mintGreen,
        unselectedItemColor: AppColors.lavender,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: AppRadius.cardRadius,
        ),
        filled: true,
        fillColor: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.7),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.chipRadius,
        ),
      ),
    );
  }
}
