import '../../models/user_model.dart';

/// Mock user data for development
class MockUserService {
  Future<UserModel> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return UserModel(
      id: 'user_001',
      firstName: 'Ana',
      lastName: 'Novak',
      userType: UserType.pregnant,
      dueDate: DateTime.now().add(const Duration(days: 120)),
      dailyWaterGoal: 2000,
      preferredLanguage: 'sl',
      isPremium: true,
      premiumUntil: DateTime.now().add(const Duration(days: 180)),
      onboardingCompleted: true,
    );
  }

  Future<void> updateUser(UserModel user) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
