import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../models/food_introduction_model.dart';
import '../../../providers/baby_provider.dart';

/// One food in the introduction guide: mark as introduced and note
/// how it went — observation, never judgement.
class FoodItemTile extends StatelessWidget {
  final FoodIntroductionModel food;

  const FoodItemTile({super.key, required this.food});

  static const _reactions = [
    ('ok', '🙂 V redu'),
    ('ni marala', '😕 Ni še navdušen'),
    ('reakcija', '⚠️ Reakcija'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: food.introduced
            ? AppColors.mintGreen.withValues(alpha: 0.1)
            : Theme.of(context).colorScheme.surface,
        borderRadius: AppRadius.cardRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(food.emoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(food.name,
                        style: Theme.of(context).textTheme.titleMedium),
                    Text(
                      food.category,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              Checkbox(
                value: food.introduced,
                shape: const CircleBorder(),
                onChanged: (_) {
                  HapticFeedback.selectionClick();
                  context
                      .read<BabyProvider>()
                      .toggleIntroduced(food.foodId);
                },
              ),
            ],
          ),
          if (food.note.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              food.note,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
          if (food.introduced) ...[
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              children: [
                for (final (value, label) in _reactions)
                  ChoiceChip(
                    label: Text(label,
                        style: Theme.of(context).textTheme.bodySmall),
                    selected: food.reaction == value,
                    onSelected: (_) => context
                        .read<BabyProvider>()
                        .setReaction(food.foodId, value),
                  ),
              ],
            ),
            if (food.reaction == 'reakcija') ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Ob izpuščaju, bruhanju ali težavah z dihanjem se '
                'posvetuj s pediatrom.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
