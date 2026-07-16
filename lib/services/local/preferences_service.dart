import 'package:shared_preferences/shared_preferences.dart';

/// Wrapper around SharedPreferences for simple key-value storage
class PreferencesService {
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences get _p {
    assert(_prefs != null, 'PreferencesService not initialized. Call init() first.');
    return _prefs!;
  }

  // Theme
  Future<void> setThemeMode(String mode) => _p.setString('theme_mode', mode);
  String getThemeMode() => _p.getString('theme_mode') ?? 'system';

  // Locale
  Future<void> setLocale(String locale) => _p.setString('locale', locale);
  String getLocale() => _p.getString('locale') ?? 'sl';

  // Onboarding
  Future<void> setOnboardingCompleted(bool value) =>
      _p.setBool('onboarding_completed', value);
  bool getOnboardingCompleted() =>
      _p.getBool('onboarding_completed') ?? false;
}
