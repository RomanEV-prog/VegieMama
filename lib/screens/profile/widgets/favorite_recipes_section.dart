import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../models/recipe_model.dart';
import '../../../providers/recipes_provider.dart';
import '../../../widgets/section_title.dart';

/// Horizontal preview of favorite recipes with a gentle empty state.
class FavoriteRecipesSection extends StatelessWidget {
  const FavoriteRecipesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipesProvider>(
      builder: (context, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
              title: 'Najljubši recepti',
              actionLabel: 'Vsi recepti',
              onAction: () => context.go('/recipes'),
            ),
            if (provider.favorites.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                child: Text(
                  'Ko ti bo kakšen recept pri srcu, ga označi s srčkom in te bo čakal tukaj 💚',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              )
            else
              SizedBox(
                height: 96,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenPadding,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.favorites.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppSpacing.md),
                  itemBuilder: (context, index) =>
                      _RecipeCard(recipe: provider.favorites[index]),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _RecipeCard extends StatelessWidget {
  final RecipeModel recipe;

  const _RecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/recipes/${recipe.id}'),
      borderRadius: AppRadius.cardRadius,
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.mintGreen.withValues(alpha: 0.1),
          borderRadius: AppRadius.cardRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recipe.title,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.schedule,
                    size: 14, color: AppColors.textSecondary),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '${recipe.prepTimeMinutes} min',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const Spacer(),
                const Icon(Icons.favorite,
                    size: 16, color: AppColors.error),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
