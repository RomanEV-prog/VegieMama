/// Date calculation helpers for pregnancy weeks and baby age
class DateHelper {
  DateHelper._();

  /// Calculate current pregnancy week from due date (40 weeks total)
  static int pregnancyWeek(DateTime dueDate) {
    final conception = dueDate.subtract(const Duration(days: 280));
    final now = DateTime.now();
    final diff = now.difference(conception).inDays;
    final week = (diff / 7).floor();
    return week.clamp(1, 42);
  }

  /// Calculate trimester (1, 2, or 3) from due date
  static int trimester(DateTime dueDate) {
    final week = pregnancyWeek(dueDate);
    if (week <= 13) return 1;
    if (week <= 27) return 2;
    return 3;
  }

  /// Calculate baby age in months from birth date
  static int babyAgeInMonths(DateTime birthDate) {
    final now = DateTime.now();
    int months = (now.year - birthDate.year) * 12 + now.month - birthDate.month;
    if (now.day < birthDate.day) months--;
    return months.clamp(0, 999);
  }

  /// Calculate baby age in weeks from birth date
  static int babyAgeInWeeks(DateTime birthDate) {
    final now = DateTime.now();
    return now.difference(birthDate).inDays ~/ 7;
  }

  /// Friendly display of pregnancy week
  static String pregnancyWeekDisplay(DateTime dueDate) {
    final week = pregnancyWeek(dueDate);
    return '$week. teden nosečnosti';
  }

  /// Friendly display of baby age
  static String babyAgeDisplay(DateTime birthDate) {
    final months = babyAgeInMonths(birthDate);
    if (months < 1) {
      final weeks = babyAgeInWeeks(birthDate);
      return '$weeks ${_weeksLabel(weeks)}';
    }
    return '$months ${_monthsLabel(months)}';
  }

  static String _weeksLabel(int weeks) {
    if (weeks == 1) return 'teden';
    if (weeks == 2) return 'tedna';
    if (weeks == 3 || weeks == 4) return 'tedne';
    return 'tednov';
  }

  static String _monthsLabel(int months) {
    if (months == 1) return 'mesec';
    if (months == 2) return 'meseca';
    if (months == 3 || months == 4) return 'mesece';
    return 'mesecev';
  }
}
