import 'package:flutter/foundation.dart';
import '../models/achievement_model.dart';

class AchievementsProvider extends ChangeNotifier {
  List<AchievementModel> _achievements = [];
  bool _isLoading = false;

  List<AchievementModel> get achievements => _achievements;
  List<AchievementModel> get unlocked =>
      _achievements.where((a) => a.isUnlocked).toList();
  bool get isLoading => _isLoading;

  Future<void> loadAchievements() async {
    _isLoading = true;
    notifyListeners();

    // Mock data
    await Future.delayed(const Duration(milliseconds: 300));
    _achievements = [
      const AchievementModel(
        id: 'first_water',
        title: 'Prvi požirek',
        description: 'Prvič si zabeležila vnos vode',
        icon: '💧',
        currentCount: 1,
        requiredCount: 1,
        isUnlocked: true,
      ),
      const AchievementModel(
        id: 'week_streak',
        title: 'Tedenski niz',
        description: '7 dni zapored beležiš vnos',
        icon: '🌟',
        currentCount: 5,
        requiredCount: 7,
      ),
      const AchievementModel(
        id: 'recipe_lover',
        title: 'Ljubiteljica receptov',
        description: 'Shranila si 5 receptov med najljubše',
        icon: '🥗',
        currentCount: 3,
        requiredCount: 5,
      ),
      const AchievementModel(
        id: 'mood_tracker',
        title: 'Pozorna nase',
        description: '10-krat si zabeležila počutje',
        icon: '🌸',
        currentCount: 10,
        requiredCount: 10,
        isUnlocked: true,
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  void incrementAchievement(String id) {
    final index = _achievements.indexWhere((a) => a.id == id);
    if (index == -1) return;

    final achievement = _achievements[index];
    final newCount = achievement.currentCount + 1;
    final unlocked = newCount >= achievement.requiredCount;

    _achievements[index] = achievement.copyWith(
      currentCount: newCount,
      isUnlocked: unlocked,
      unlockedAt: unlocked ? DateTime.now() : null,
    );
    notifyListeners();
  }
}
