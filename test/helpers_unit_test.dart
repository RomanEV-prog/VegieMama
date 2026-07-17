import 'package:flutter_test/flutter_test.dart';
import 'package:veggiemama/core/helpers/date_helper.dart';
import 'package:veggiemama/core/helpers/validation_helper.dart';
import 'package:veggiemama/providers/achievements_provider.dart';
import 'package:veggiemama/services/local/achievements_service.dart';
import 'helpers/test_env.dart';

void main() {
  group('DateHelper', () {
    test('pregnancy week from due date', () {
      // 280 days before due date = conception → week 1 shortly after.
      final dueIn70Days = DateTime.now().add(const Duration(days: 70));
      // 280 - 70 = 210 days pregnant → week 30.
      expect(DateHelper.pregnancyWeek(dueIn70Days), 30);
      expect(DateHelper.trimester(dueIn70Days), 3);

      final dueIn200Days = DateTime.now().add(const Duration(days: 200));
      // 80 days pregnant → week 11 → 1st trimester.
      expect(DateHelper.pregnancyWeek(dueIn200Days), 11);
      expect(DateHelper.trimester(dueIn200Days), 1);
    });

    test('baby age display uses Slovenian declensions', () {
      final now = DateTime.now();
      expect(
        DateHelper.babyAgeDisplay(DateTime(now.year, now.month - 1, now.day)),
        '1 mesec',
      );
      expect(
        DateHelper.babyAgeDisplay(DateTime(now.year, now.month - 2, now.day)),
        '2 meseca',
      );
      expect(
        DateHelper.babyAgeDisplay(DateTime(now.year, now.month - 5, now.day)),
        '5 mesecev',
      );
    });
  });

  group('ValidationHelper', () {
    test('name validation', () {
      expect(ValidationHelper.name(null), isNotNull);
      expect(ValidationHelper.name('A'), isNotNull);
      expect(ValidationHelper.name('Ana'), isNull);
    });

    test('water amount bounds', () {
      expect(ValidationHelper.waterAmount('250'), isNull);
      expect(ValidationHelper.waterAmount('-5'), isNotNull);
      expect(ValidationHelper.waterAmount('20000'), isNotNull);
    });
  });

  group('Achievements', () {
    setUp(() async {
      await initTestEnv();
    });

    test('unlock when counters reach thresholds', () async {
      final service = AchievementsService.instance;
      await service.increment('water_logs');
      await service.setCount('favorites', 5);

      final provider = AchievementsProvider();
      await provider.loadAchievements();

      final byId = {for (final a in provider.achievements) a.id: a};
      expect(byId['first_water']!.isUnlocked, isTrue);
      expect(byId['recipe_lover']!.isUnlocked, isTrue);
      expect(byId['mood_tracker']!.isUnlocked, isFalse);
      expect(byId['mood_tracker']!.progress, 0.0);
    });

    test('active days count once per day', () async {
      final service = AchievementsService.instance;
      await service.markActiveToday();
      await service.markActiveToday();
      await service.markActiveToday();
      expect(service.count('active_days'), 1);
    });
  });
}
