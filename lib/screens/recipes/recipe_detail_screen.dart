import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/loading_state.dart';
import '../../core/widgets/veggie_mama_app_bar.dart';
import '../../models/recipe_model.dart';
import '../../providers/recipes_provider.dart';

class RecipeDetailScreen extends StatefulWidget {
  final String recipeId;

  const RecipeDetailScreen({super.key, required this.recipeId});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _markRecentWhenAvailable();
    });
  }

  /// Marks the recipe as recently viewed. With a deep link the list may
  /// still be loading, so wait for the provider when needed.
  void _markRecentWhenAvailable() {
    final provider = context.read<RecipesProvider>();
    if (provider.recipeById(widget.recipeId) != null) {
      provider.markRecent(widget.recipeId);
      return;
    }

    late VoidCallback listener;
    listener = () {
      if (!mounted || provider.recipeById(widget.recipeId) != null) {
        provider.removeListener(listener);
        if (mounted) provider.markRecent(widget.recipeId);
      }
    };
    provider.addListener(listener);
    if (!provider.isLoading) provider.loadRecipes();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RecipesProvider>();
    final recipe = provider.recipeById(widget.recipeId);

    return Scaffold(
      appBar: const VeggieMamaAppBar(title: 'Recept', showBack: true),
      body: Builder(
        builder: (context) {
          if (recipe == null) {
            return provider.isLoading
                ? const LoadingState(message: 'Samo trenutek... 🌿')
                : const EmptyState(
                    message: 'Tega recepta ni več tukaj. Poglej ostale 💚',
                    icon: Icons.restaurant_outlined,
                  );
          }
          return _RecipeDetail(recipe: recipe);
        },
      ),
    );
  }
}

class _RecipeDetail extends StatelessWidget {
  final RecipeModel recipe;

  const _RecipeDetail({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screenPadding),
      children: [
        // Header
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.mintGreen.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              alignment: Alignment.center,
              child: Text(recipe.emoji, style: const TextStyle(fontSize: 36)),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.title,
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '${recipe.prepTimeMinutes} min priprave',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: recipe.isFavorite
                    ? AppColors.error
                    : AppColors.textLight,
              ),
              onPressed: () {
                HapticFeedback.selectionClick();
                context.read<RecipesProvider>().toggleFavorite(recipe.id);
              },
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        if (recipe.description.isNotEmpty) ...[
          Text(recipe.description,
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: AppSpacing.lg),
        ],

        // Suitability + nutrients
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final s in recipe.suitableFor)
              Chip(
                label: Text(s),
                backgroundColor: AppColors.mintGreen.withValues(alpha: 0.15),
              ),
            for (final n in recipe.nutrientsHighlights)
              Chip(
                label: Text(n),
                backgroundColor: AppColors.vitamins.withValues(alpha: 0.15),
              ),
          ],
        ),

        if (recipe.isForChild) ...[
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.lavender.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.child_care_outlined,
                    size: 20, color: AppColors.textSecondary),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Primerno približno od ${recipe.suitableFromMonth}. meseca. '
                    'Vsak otrok ima svoj tempo — o uvajanju živil se posvetuj '
                    's pediatrom.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],

        const SizedBox(height: AppSpacing.xl),
        Text('Sestavine', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.md),
        for (final ingredient in recipe.ingredients)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('•  ',
                    style: TextStyle(color: AppColors.mintGreen)),
                Expanded(
                  child: Text(ingredient,
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
              ],
            ),
          ),

        const SizedBox(height: AppSpacing.lg),
        Text('Postopek', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.md),
        for (final (index, step) in recipe.steps.indexed)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor:
                      AppColors.mintGreen.withValues(alpha: 0.2),
                  child: Text(
                    '${index + 1}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(step,
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
              ],
            ),
          ),
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}
