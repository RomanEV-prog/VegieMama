import 'package:flutter/material.dart';

/// Consistent border radius values
class AppRadius {
  AppRadius._();

  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;

  static final BorderRadius cardRadius = BorderRadius.circular(lg);
  static final BorderRadius buttonRadius = BorderRadius.circular(lg);
  static final BorderRadius chipRadius = BorderRadius.circular(sm);
  static final BorderRadius appBarRadius =
      const BorderRadius.vertical(bottom: Radius.circular(xl));
}
