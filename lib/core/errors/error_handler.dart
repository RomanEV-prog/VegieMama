import 'package:flutter/foundation.dart';
import 'app_exception.dart';

/// Centralized error handling
class ErrorHandler {
  ErrorHandler._();

  static void handle(Object error, [StackTrace? stackTrace]) {
    if (error is AppException) {
      debugPrint('⚠️ ${error.toString()}');
    } else {
      debugPrint('❌ Unexpected error: $error');
    }
    if (stackTrace != null) {
      debugPrint(stackTrace.toString());
    }
  }

  /// Returns a gentle user-facing message
  static String userMessage(Object error) {
    if (error is NetworkException) {
      return 'Povezava ni uspela. Poskusi znova čez trenutek. 💚';
    }
    if (error is StorageException) {
      return 'Podatkov ni bilo mogoče shraniti. Poskusi znova. 💚';
    }
    return 'Nekaj je šlo narobe. Brez skrbi, poskusi znova. 💚';
  }
}
