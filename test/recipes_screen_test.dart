import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:veggiemama/providers/recipes_provider.dart';
import 'package:veggiemama/screens/recipes/recipe_detail_screen.dart';
import 'package:veggiemama/screens/recipes/recipes_screen.dart';
import 'helpers/test_env.dart';

Widget _buildApp({String initialLocation = '/recipes'}) {
  final router = GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(path: '/recipes', builder: (_, __) => const RecipesScreen()),
      GoRoute(
        path: '/recipes/:id',
        builder: (_, state) =>
            RecipeDetailScreen(recipeId: state.pathParameters['id']!),
      ),
    ],
  );
  return ChangeNotifierProvider(
    create: (_) => RecipesProvider()..loadRecipes(),
    child: MaterialApp.router(routerConfig: router),
  );
}

Future<void> _pumpLoaded(WidgetTester tester,
    {String initialLocation = '/recipes'}) async {
  await tester.pumpWidget(_buildApp(initialLocation: initialLocation));
  await tester.pump(const Duration(milliseconds: 600));
  await tester.pump();
}

void main() {
  setUp(() async {
    await initTestEnv();
  });

  testWidgets('recipes screen shows favorites row, filters and list',
      (tester) async {
    await _pumpLoaded(tester);

    expect(find.text('Tvoji najljubši'), findsOneWidget);
    expect(find.text('Uvajanje hrane'), findsOneWidget);
    // r1 appears in the favorites row AND in the list.
    expect(find.text('Zeleni smoothie z banano in špinačo'),
        findsAtLeastNWidgets(1));
  });

  testWidgets('filter narrows the list and can be cleared', (tester) async {
    await _pumpLoaded(tester);

    final provider = tester
        .element(find.byType(RecipesScreen))
        .read<RecipesProvider>();

    await tester.tap(find.text('Uvajanje hrane'));
    await tester.pump();
    expect(provider.recipes.length, 3); // r6, r7, r14

    await tester.scrollUntilVisible(
      find.text('Počisti'),
      100,
      scrollable: find
          .ancestor(
            of: find.text('Železo'),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Počisti'));
    await tester.pump();
    expect(provider.recipes.length, 14);
  });

  testWidgets('favorite toggle updates provider state', (tester) async {
    await _pumpLoaded(tester);

    final provider = tester
        .element(find.byType(RecipesScreen))
        .read<RecipesProvider>();
    expect(provider.favorites.length, 3);

    provider.toggleFavorite('r4');
    await tester.pump();
    expect(provider.favorites.length, 4);
    expect(provider.recipeById('r4')!.isFavorite, isTrue);
  });

  testWidgets('detail shows ingredients, steps and child disclaimer',
      (tester) async {
    await _pumpLoaded(tester, initialLocation: '/recipes/r6');
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();

    expect(find.text('Korenčkova kašica'), findsOneWidget);
    expect(find.text('Sestavine'), findsOneWidget);
    expect(find.text('Postopek'), findsOneWidget);
    expect(find.textContaining('od 6. meseca'), findsOneWidget);
    expect(find.textContaining('posvetuj'), findsOneWidget);

    // Opening the detail marks the recipe as recent.
    final provider = tester
        .element(find.byType(RecipeDetailScreen))
        .read<RecipesProvider>();
    expect(provider.recipeById('r6')!.isRecent, isTrue);
  });
}
