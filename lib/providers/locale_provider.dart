import 'package:flutter/material.dart';
import '../services/local/preferences_service.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider() {
    if (PreferencesService.instance.isInitialized) {
      final stored = Locale(PreferencesService.instance.getLocale());
      if (supportedLocales.contains(stored)) _locale = stored;
    }
  }

  Locale _locale = const Locale('sl');

  Locale get locale => _locale;

  static const List<Locale> supportedLocales = [
    Locale('sl'),
    Locale('en'),
    Locale('de'),
  ];

  void setLocale(Locale locale) {
    if (!supportedLocales.contains(locale)) return;
    _locale = locale;
    notifyListeners();
    if (PreferencesService.instance.isInitialized) {
      PreferencesService.instance.setLocale(locale.languageCode);
    }
  }

  void setLocaleByCode(String code) {
    setLocale(Locale(code));
  }
}
