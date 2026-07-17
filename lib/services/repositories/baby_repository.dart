import '../../models/baby_profile_model.dart';
import '../../models/food_introduction_model.dart';
import '../local/storage_service.dart';
import '../mock/mock_food_guide_service.dart';

/// Baby profile and food-introduction progress live locally (Hive);
/// the food catalogue itself comes from the mock service.
class BabyRepository {
  final MockFoodGuideService _foodGuide = MockFoodGuideService();
  final StorageService _storage = StorageService.instance;

  static const _babyKey = 'baby_profile';
  static const _foodProgressKey = 'food_intro_progress';
  static const _userBoxName = 'user_box';
  static const _appBoxName = 'app_box';

  Future<BabyProfileModel?> getBaby() async {
    final data = _storage.load(_userBoxName, _babyKey);
    if (data == null) return null;
    return BabyProfileModel.fromJson(data);
  }

  Future<void> saveBaby(BabyProfileModel baby) =>
      _storage.save(_userBoxName, _babyKey, baby.toJson());

  /// Catalogue merged with the stored per-food progress.
  Future<List<FoodIntroductionModel>> getFoodGuide() async {
    final catalogue = await _foodGuide.getCatalogue();
    final stored = _storage.load(_appBoxName, _foodProgressKey);
    if (stored == null) return catalogue;

    return [
      for (final food in catalogue)
        stored[food.foodId] != null
            ? food.withProgressFromJson(
                (stored[food.foodId] as Map).cast<String, dynamic>())
            : food,
    ];
  }

  Future<void> saveFoodProgress(List<FoodIntroductionModel> foods) {
    final progress = {
      for (final f in foods)
        if (f.introduced || f.reaction != null || f.notes != null)
          f.foodId: f.progressToJson(),
    };
    return _storage.save(_appBoxName, _foodProgressKey, progress);
  }
}
