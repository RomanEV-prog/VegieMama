import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/error_state.dart';
import '../../core/widgets/loading_state.dart';
import '../../core/widgets/veggie_mama_app_bar.dart';
import '../../models/user_model.dart';
import '../../providers/recipes_provider.dart';
import '../../providers/user_provider.dart';
import 'widgets/favorites_row.dart';
import 'widgets/recipe_card.dart';
import 'widgets/recipe_filters.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  static const _defaultFilterByType = {
    UserType.babyMom: 'uvajanje hrane',
    UserType.toddlerMom: 'malček',
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final userType = context.read<UserProvider>().userType;
      context
          .read<RecipesProvider>()
          .applyDefaultFilter(_defaultFilterByType[userType]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RecipesProvider>();

    return Scaffold(
      appBar: const VeggieMamaAppBar(title: 'Recepti'),
      body: Builder(
        builder: (context) {
          if (provider.isLoading && provider.recipes.isEmpty) {
            return const LoadingState(message: 'Pripravljam recepte... 🌿');
          }
          if (provider.error != null && provider.recipes.isEmpty) {
            return ErrorState(
              error: provider.error!,
              onRetry: () => context.read<RecipesProvider>().loadRecipes(),
            );
          }

          return RefreshIndicator(
            onRefresh: () => context.read<RecipesProvider>().loadRecipes(),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(
                top: AppSpacing.sm,
                bottom: AppSpacing.xl,
              ),
              children: [
                const FavoritesRow(),
                const SizedBox(height: AppSpacing.sm),
                const RecipeFilters(),
                const SizedBox(height: AppSpacing.sm),
                if (provider.recipes.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: AppSpacing.xxl),
                    child: EmptyState(
                      message:
                          'Za izbrane filtre ni receptov. Poskusi z manj filtri 💚',
                      icon: Icons.restaurant_outlined,
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPadding,
                    ),
                    child: Column(
                      children: [
                        for (final recipe in provider.recipes) ...[
                          RecipeCard(recipe: recipe),
                          const SizedBox(height: AppSpacing.md),
                        ],
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
