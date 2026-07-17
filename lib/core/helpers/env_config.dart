import 'package:flutter/services.dart';

/// Minimal .env loader (asset, gitignored). No extra packages —
/// pattern taken from the GreenHeart project.
class EnvConfig {
  EnvConfig._();

  static String geminiApiKey = '';

  static bool get hasGemini => geminiApiKey.isNotEmpty;

  static Future<void> load() async {
    try {
      final raw = await rootBundle.loadString('.env');
      for (final line in raw.split('\n')) {
        final trimmed = line.trim();
        if (trimmed.startsWith('GEMINI_API_KEY=')) {
          geminiApiKey =
              trimmed.substring('GEMINI_API_KEY='.length).trim();
        }
      }
    } catch (_) {
      // No .env bundled — the app runs in mock mode.
    }
  }
}
