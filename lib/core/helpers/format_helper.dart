import 'package:intl/intl.dart';

/// Formatting helpers
class FormatHelper {
  FormatHelper._();

  /// Format ml to display string (e.g., "1.250 ml")
  static String waterAmount(int ml) {
    if (ml >= 1000) {
      return '${NumberFormat('#,###', 'sl').format(ml)} ml';
    }
    return '$ml ml';
  }

  /// Format percentage (0-1) to display string
  static String percent(double value) {
    return '${(value * 100).round()}%';
  }

  /// Format hours to sleep display
  static String sleepHours(double hours) {
    final h = hours.floor();
    final m = ((hours - h) * 60).round();
    if (m == 0) return '${h}h';
    return '${h}h ${m}min';
  }

  /// Format date to short display
  static String shortDate(DateTime date) {
    return DateFormat('d. M. yyyy').format(date);
  }

  /// Format date to day name
  static String dayName(DateTime date) {
    return DateFormat('EEEE', 'sl').format(date);
  }
}
