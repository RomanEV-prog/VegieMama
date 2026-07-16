import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../models/recipe_model.dart';
import '../../../providers/recipes_provider.dart';

/// Recipe list card: emoji placeholder, title, tags and favorite heart.
class RecipeCard extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => context.push('/recipes/${recipe.id}'),
        borderRadius: AppRadius.cardRadius,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.mintGreen.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                alignment: Alignment.center,
                child: Text(recipe.emoji,
                    style: const TextStyle(fontSize: 28)),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        const Icon(Icons.schedule,
                            size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          '${recipe.prepTimeMinutes} min',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                        if (recipe.isForChild) ...[
                          const SizedBox(width: AppSpacing.md),
                          const Icon(Icons.child_care_outlined,
                              size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            'od ${recipe.suitableFromMonth}. meseca',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  recipe.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: recipe.isFavorite
                      ? AppColors.error
                      : AppColors.textLight,
                ),
                tooltip: recipe.isFavorite
                    ? 'Odstrani iz najljubših'
                    : 'Dodaj med najljubše',
                onPressed: () {
                  HapticFeedback.selectionClick();
                  context.read<RecipesProvider>().toggleFavorite(recipe.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
