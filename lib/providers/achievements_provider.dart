import 'package:flutter/foundation.dart';
import '../models/achievement_model.dart';
import '../services/local/achievements_service.dart';

/// Achievements derived from real, persisted usage counters.
/// Definitions live here; counts come from [AchievementsService].
class AchievementsProvider extends ChangeNotifier {
  final AchievementsService _service = AchievementsService.instance;

  List<AchievementModel> _achievements = [];
  bool _isLoading = false;

  List<AchievementModel> get achievements => _achievements;
  List<AchievementModel> get unlocked =>
      _achievements.where((a) => a.isUnlocked).toList();
  bool get isLoading => _isLoading;

  static const _definitions = [
    (
      id: 'first_water',
      counter: 'water_logs',
      title: 'Prvi požirek',
      description: 'Prvič si zabeležila vnos vode',
      icon: '💧',
      required: 1,
    ),
    (
      id: 'gentle_days',
      counter: 'active_days',
      title: 'Nežna zvestoba',
      description: '7 dni z vsaj enim vnosom — v svojem tempu',
      icon: '🌟',
      required: 7,
    ),
    (
      id: 'recipe_lover',
      counter: 'favorites',
      title: 'Ljubiteljica receptov',
      description: 'Shranila si 5 receptov med najljubše',
      icon: '🥗',
      required: 5,
    ),
    (
      id: 'mood_tracker',
      counter: 'mood_logs',
      title: 'Pozorna nase',
      description: '10-krat si zabeležila počutje',
      icon: '🌸',
      required: 10,
    ),
    (
      id: 'first_food',
      counter: 'foods_introduced',
      title: 'Prva žlička',
      description: 'Malček je poskusil prvo živilo',
      icon: '🥄',
      required: 1,
    ),
    (
      id: 'food_explorer',
      counter: 'foods_introduced',
      title: 'Mala raziskovalka okusov',
      description: '10 uvedenih živil iz vodnika',
      icon: '🥕',
      required: 10,
    ),
  ];

  Future<void> loadAchievements() async {
    _isLoading = true;
    notifyListeners();

    _achievements = [
      for (final d in _definitions)
        AchievementModel(
          id: d.id,
          title: d.title,
          description: d.description,
          icon: d.icon,
          currentCount: _service.count(d.counter),
          requiredCount: d.required,
          isUnlocked: _service.count(d.counter) >= d.required,
        ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  /// Re-reads counters — call after screens report new events.
  void refresh() => loadAchievements();
}
