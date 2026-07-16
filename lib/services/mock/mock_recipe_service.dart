import '../../models/recipe_model.dart';

/// Mock recipe data for development
class MockRecipeService {
  Future<List<RecipeModel>> getAllRecipes() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      const RecipeModel(
        id: 'r1',
        title: 'Zeleni smoothie z bananami',
        tags: ['zajtrk', 'hitro', 'smoothie'],
        isFavorite: true,
        isRecent: true,
        suitableFor: ['pregnancy', 'breastfeeding'],
        nutrientsHighlights: ['železo', 'folna kislina'],
        prepTimeMinutes: 5,
      ),
      const RecipeModel(
        id: 'r2',
        title: 'Lečin curry z riževimi rezanci',
        tags: ['kosilo', 'beljakovine'],
        isFavorite: true,
        suitableFor: ['pregnancy', 'breastfeeding', 'baby'],
        nutrientsHighlights: ['beljakovine', 'železo'],
        prepTimeMinutes: 25,
      ),
      const RecipeModel(
        id: 'r3',
        title: 'Ovsena kaša z jagodami',
        tags: ['zajtrk', 'hitro'],
        isRecent: true,
        suitableFor: ['pregnancy', 'breastfeeding', 'baby'],
        nutrientsHighlights: ['vlaknine', 'B12'],
        prepTimeMinutes: 10,
      ),
      const RecipeModel(
        id: 'r4',
        title: 'Humus s korenčkom',
        tags: ['prigrizek', 'hitro'],
        suitableFor: ['pregnancy', 'breastfeeding', 'baby'],
        nutrientsHighlights: ['beljakovine', 'železo'],
        prepTimeMinutes: 15,
      ),
      const RecipeModel(
        id: 'r5',
        title: 'Tofujev stir-fry z brokolijem',
        tags: ['večerja', 'beljakovine'],
        isFavorite: true,
        suitableFor: ['pregnancy', 'breastfeeding'],
        nutrientsHighlights: ['beljakovine', 'kalcij', 'železo'],
        prepTimeMinutes: 20,
      ),
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
}
