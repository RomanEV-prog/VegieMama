import '../../models/recipe_model.dart';
import '../mock/mock_recipe_service.dart';

class RecipeRepository {
  final MockRecipeService _service = MockRecipeService();

  Future<List<RecipeModel>> getAllRecipes() => _service.getAllRecipes();
  Future<List<RecipeModel>> getFavorites() => _service.getFavorites();
  Future<List<RecipeModel>> getRecent() => _service.getRecent();
}
