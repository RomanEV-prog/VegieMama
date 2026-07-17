import 'package:flutter/foundation.dart';
import '../models/baby_profile_model.dart';
import '../models/food_introduction_model.dart';
import '../services/local/achievements_service.dart';
import '../services/repositories/baby_repository.dart';

class BabyProvider extends ChangeNotifier {
  final BabyRepository _repository = BabyRepository();

  BabyProfileModel? _baby;
  List<FoodIntroductionModel> _foodGuide = [];
  bool _isLoading = false;
  String? _error;

  BabyProfileModel? get baby => _baby;
  List<FoodIntroductionModel> get foodGuide => _foodGuide;
  bool get isLoading => _isLoading;
  String? get error => _error;

  int get introducedCount =>
      _foodGuide.where((f) => f.introduced).length;

  /// Foods appropriate for the baby's current age (or all when no baby).
  List<FoodIntroductionModel> get foodsForCurrentAge {
    final months = _baby?.ageInMonths;
    if (months == null) return _foodGuide;
    return _foodGuide
        .where((f) => f.recommendedFromMonth <= months)
        .toList();
  }

  Future<void> load() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _baby = await _repository.getBaby();
      _foodGuide = List.of(await _repository.getFoodGuide());
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveBaby(BabyProfileModel baby) async {
    _baby = baby;
    notifyListeners();
    await _repository.saveBaby(baby);
  }

  /// Creates the baby profile from the user's stored birth date when
  /// none exists yet.
  Future<void> ensureBaby(DateTime birthDate) async {
    if (_baby != null) return;
    await saveBaby(BabyProfileModel(
      id: 'baby_${DateTime.now().millisecondsSinceEpoch}',
      name: '',
      birthDate: birthDate,
    ));
  }

  void toggleIntroduced(String foodId) {
    final index = _foodGuide.indexWhere((f) => f.foodId == foodId);
    if (index == -1) return;

    final food = _foodGuide[index];
    final nowIntroduced = !food.introduced;
    // copyWith can't null fields out, so rebuild explicitly: un-marking
    // clears the timestamp and reaction.
    _foodGuide[index] = FoodIntroductionModel(
      foodId: food.foodId,
      name: food.name,
      emoji: food.emoji,
      category: food.category,
      recommendedFromMonth: food.recommendedFromMonth,
      note: food.note,
      introduced: nowIntroduced,
      introducedAt: nowIntroduced ? DateTime.now() : null,
      reaction: nowIntroduced ? food.reaction : null,
      notes: food.notes,
    );
    notifyListeners();
    _persistProgress();
  }

  void setReaction(String foodId, String reaction) {
    final index = _foodGuide.indexWhere((f) => f.foodId == foodId);
    if (index == -1) return;

    _foodGuide[index] = _foodGuide[index].copyWith(reaction: reaction);
    notifyListeners();
    _persistProgress();
  }

  void _persistProgress() {
    _repository.saveFoodProgress(_foodGuide).catchError((Object e) {
      _error = e.toString();
    });
    AchievementsService.instance
        .setCount('foods_introduced', introducedCount);
  }
}
