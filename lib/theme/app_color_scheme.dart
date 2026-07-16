import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Light and dark color schemes for VeggieMama
class AppColorScheme {
  AppColorScheme._();

  static const ColorScheme light = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.mintGreen,
    onPrimary: Colors.white,
    secondary: AppColors.lavender,
    onSecondary: AppColors.textPrimary,
    error: AppColors.error,
    onError: Colors.white,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
  );

  static const ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.mintGreen,
    onPrimary: Colors.white,
    secondary: AppColors.lavender,
    onSecondary: Colors.white,
    error: AppColors.error,
    onError: Colors.white,
    surface: AppColors.darkSurface,
    onSurface: Colors.white,
  );
}
