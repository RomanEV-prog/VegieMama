import 'package:flutter/material.dart';
import '../services/local/preferences_service.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    if (PreferencesService.instance.isInitialized) {
      _themeMode = _fromName(PreferencesService.instance.getThemeMode());
    }
  }

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  static ThemeMode _fromName(String name) => ThemeMode.values.firstWhere(
        (m) => m.name == name,
        orElse: () => ThemeMode.system,
      );

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
    if (PreferencesService.instance.isInitialized) {
      PreferencesService.instance.setThemeMode(mode.name);
    }
  }

  void toggleTheme() {
    switch (_themeMode) {
      case ThemeMode.light:
        setThemeMode(ThemeMode.dark);
      case ThemeMode.dark:
        setThemeMode(ThemeMode.system);
      case ThemeMode.system:
        setThemeMode(ThemeMode.light);
    }
  }
}
