import 'package:flutter/foundation.dart';
import '../models/recipe_model.dart';
import '../services/repositories/recipe_repository.dart';

class RecipesProvider extends ChangeNotifier {
  final RecipeRepository _repository = RecipeRepository();

  List<RecipeModel> _recipes = [];
  List<RecipeModel> _favorites = [];
  List<RecipeModel> _recent = [];
  final Set<String> _activeFilters = {};
  bool _isLoading = false;
  String? _error;

  List<RecipeModel> get recipes => _filteredRecipes;
  List<RecipeModel> get favorites => _favorites;
  List<RecipeModel> get recent => _recent;
  Set<String> get activeFilters => _activeFilters;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<RecipeModel> get _filteredRecipes {
    if (_activeFilters.isEmpty) return _recipes;
    return _recipes.where((r) {
      return _activeFilters.every((f) =>
          r.tags.contains(f) ||
          r.suitableFor.contains(f) ||
          r.nutrientsHighlights.contains(f));
    }).toList();
  }

  Future<void> loadRecipes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _recipes = await _repository.getAllRecipes();
      _favorites = await _repository.getFavorites();
      _recent = await _repository.getRecent();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleFilter(String filter) {
    if (_activeFilters.contains(filter)) {
      _activeFilters.remove(filter);
    } else {
      _activeFilters.add(filter);
    }
    notifyListeners();
  }

  void clearFilters() {
    _activeFilters.clear();
    notifyListeners();
  }

  void toggleFavorite(String recipeId) {
    final index = _recipes.indexWhere((r) => r.id == recipeId);
    if (index == -1) return;

    final recipe = _recipes[index];
    _recipes[index] = recipe.copyWith(isFavorite: !recipe.isFavorite);
    _favorites = _recipes.where((r) => r.isFavorite).toList();
    notifyListeners();
  }
}
