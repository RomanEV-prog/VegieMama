import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../models/tracking_data_model.dart';
import '../../../providers/tracking_provider.dart';

/// Child meals for baby/toddler stages. For toddlers it adds gentle
/// nutrient-coverage chips — information, never a grade.
class BabyMealsCard extends StatelessWidget {
  final TrackingDataModel today;
  final bool showNutrients;

  const BabyMealsCard({
    super.key,
    required this.today,
    this.showNutrients = false,
  });

  static const _nutrients = [
    'B12',
    'Železo',
    'Kalcij',
    'Omega-3',
    'Vitamin D',
    'Beljakovine',
    'Jod',
    'Cink',
  ];

  String _label(int count) {
    if (count == 0) return 'Danes še ni zabeleženih obrokov';
    if (count == 1) return '1 obrok otroka';
    if (count == 2) return '2 obroka otroka';
    if (count <= 4) return '$count obroki otroka';
    return '$count obrokov otroka';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('🧸', style: TextStyle(fontSize: 20)),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Obroki otroka',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        _label(today.babyMeals),
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                      ),
                    ],
                  ),
                ),
                FilledButton.tonalIcon(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    context.read<TrackingProvider>().logBabyMeal();
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Obrok'),
                ),
              ],
            ),
            if (showNutrients) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                'Kaj je bilo danes na krožniku? Označi hranila:',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  for (final nutrient in _nutrients)
                    FilterChip(
                      label: Text(nutrient),
                      selected: today.nutrientCoverage.contains(nutrient),
                      selectedColor:
                          AppColors.mintGreen.withValues(alpha: 0.25),
                      onSelected: (_) {
                        HapticFeedback.selectionClick();
                        context
                            .read<TrackingProvider>()
                            .toggleNutrient(nutrient);
                      },
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Informacija zase, ne ocena. Pester teden šteje več kot popoln dan 💚',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
