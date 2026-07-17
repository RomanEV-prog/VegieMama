import 'storage_service.dart';

/// Persistent counters behind achievements. Providers report events
/// here; [AchievementsProvider] turns counts into unlocked badges.
class AchievementsService {
  AchievementsService._();
  static final AchievementsService instance = AchievementsService._();

  static const _boxName = 'app_box';
  static const _countersKey = 'achievement_counters';

  Map<String, dynamic> _counters() =>
      StorageService.instance.load(_boxName, _countersKey) ?? {};

  int count(String key) => (_counters()[key] as int?) ?? 0;

  Future<void> increment(String key, [int by = 1]) {
    final counters = _counters();
    counters[key] = ((counters[key] as int?) ?? 0) + by;
    return StorageService.instance.save(_boxName, _countersKey, counters);
  }

  Future<void> setCount(String key, int value) {
    final counters = _counters();
    counters[key] = value;
    return StorageService.instance.save(_boxName, _countersKey, counters);
  }

  /// Counts distinct days with at least one entry (gentle "loyalty",
  /// deliberately NOT a streak — a missed day never resets anything).
  Future<void> markActiveToday() async {
    final counters = _counters();
    final today = DateTime.now();
    final todayKey =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    if (counters['last_active_day'] == todayKey) return;

    counters['last_active_day'] = todayKey;
    counters['active_days'] = ((counters['active_days'] as int?) ?? 0) + 1;
    await StorageService.instance.save(_boxName, _countersKey, counters);
  }
}
