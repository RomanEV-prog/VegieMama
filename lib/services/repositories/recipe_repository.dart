import '../../models/recipe_model.dart';
import '../local/storage_service.dart';
import '../mock/mock_recipe_service.dart';

/// Recipes come from the mock catalogue; favorite marks are the
/// user's own data and persist locally.
class RecipeRepository {
  final MockRecipeService _service = MockRecipeService();
  final StorageService _storage = StorageService.instance;

  Future<List<RecipeModel>> getAllRecipes() async {
    final recipes = await _service.getAllRecipes();
    final storedFavorites = _storage.loadFavoriteIds();
    if (storedFavorites == null) return recipes;

    final ids = storedFavorites.toSet();
    return [
      for (final r in recipes) r.copyWith(isFavorite: ids.contains(r.id)),
    ];
  }

  Future<List<RecipeModel>> getFavorites() async {
    final all = await getAllRecipes();
    return all.where((r) => r.isFavorite).toList();
  }

  Future<List<RecipeModel>> getRecent() async {
    final all = await getAllRecipes();
    return all.where((r) => r.isRecent).toList();
  }

  Future<void> saveFavoriteIds(List<String> ids) =>
      _storage.saveFavoriteIds(ids);
}
