import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
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
  }

  void setLocaleByCode(String code) {
    setLocale(Locale(code));
  }
}
