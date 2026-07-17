import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veggiemama/models/baby_profile_model.dart';
import 'package:veggiemama/models/tracking_data_model.dart';
import 'package:veggiemama/models/user_model.dart';
import 'package:veggiemama/services/local/preferences_service.dart';
import 'package:veggiemama/services/local/storage_service.dart';
import 'package:veggiemama/services/repositories/tracking_repository.dart';

/// The user most tests expect: pregnant, premium, mid-pregnancy.
UserModel testUser() => UserModel(
      id: 'test_user',
      firstName: 'Ana',
      lastName: 'Novak',
      userType: UserType.pregnant,
      dueDate: DateTime.now().add(const Duration(days: 120)),
      isPremium: true,
      premiumUntil: DateTime.now().add(const Duration(days: 180)),
      onboardingCompleted: true,
    );

/// Today's tracking data most tests expect.
TrackingDataModel testToday() => TrackingDataModel(
      date: DateTime.now(),
      waterIntake: 1250,
      waterGoal: 2000,
      sleepHours: 7.5,
      sleepGoal: 8,
      moodRating: 4,
      mealsLogged: 2,
      vitamins: const ['B12', 'Železo', 'Vitamin D'],
    );

/// Initializes Hive + SharedPreferences for widget tests and seeds
/// them. Pass null to leave a store empty (e.g. onboarding tests).
Future<void> initTestEnv({
  UserModel? user,
  TrackingDataModel? today,
}) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  await PreferencesService.instance.init();

  // In-memory store: no real I/O, safe inside the FakeAsync test zone.
  await StorageService.instance.init(inMemory: true);
  await StorageService.instance.clearAll();

  if (user != null) await seedUser(user);
  if (today != null) await seedToday(today);
}

/// Seeds the stored user (call via tester.runAsync inside testWidgets).
Future<void> seedUser(UserModel user) async {
  await StorageService.instance.saveUser(user.toJson());
  await PreferencesService.instance
      .setOnboardingCompleted(user.onboardingCompleted);
}

/// Seeds today's tracking entry (call via tester.runAsync inside
/// testWidgets).
Future<void> seedToday(TrackingDataModel today) {
  return StorageService.instance.saveTracking(
    TrackingRepository.dateKey(today.date),
    today.toJson(),
  );
}

/// Seeds the stored baby profile.
Future<void> seedBaby(BabyProfileModel baby) =>
    StorageService.instance.save('user_box', 'baby_profile', baby.toJson());
