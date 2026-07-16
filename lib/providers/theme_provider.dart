import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void toggleTheme() {
    switch (_themeMode) {
      case ThemeMode.light:
        _themeMode = ThemeMode.dark;
      case ThemeMode.dark:
        _themeMode = ThemeMode.system;
      case ThemeMode.system:
        _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
}
