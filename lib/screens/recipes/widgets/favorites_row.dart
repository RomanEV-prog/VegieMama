import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../providers/recipes_provider.dart';
import '../../../widgets/section_title.dart';

/// Compact horizontal strip of favorite recipes at the top of the list.
class FavoritesRow extends StatelessWidget {
  const FavoritesRow({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<RecipesProvider>().favorites;
    if (favorites.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Tvoji najljubši'),
        SizedBox(
          height: 72,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            itemCount: favorites.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, index) {
              final recipe = favorites[index];
              return InkWell(
                onTap: () => context.push('/recipes/${recipe.id}'),
                borderRadius: AppRadius.cardRadius,
                child: Container(
                  width: 160,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.peach.withValues(alpha: 0.6),
                    borderRadius: AppRadius.cardRadius,
                  ),
                  child: Row(
                    children: [
                      Text(recipe.emoji,
                          style: const TextStyle(fontSize: 24)),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          recipe.title,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
