import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../models/tracking_data_model.dart';
import '../../../providers/tracking_provider.dart';

/// Meal logging card — a simple counter, no judgement about amounts.
class MealsCard extends StatelessWidget {
  final TrackingDataModel today;

  const MealsCard({super.key, required this.today});

  String _label(int count) {
    if (count == 0) return 'Danes še ni zabeleženih obrokov';
    if (count == 1) return '1 zabeležen obrok';
    if (count == 2) return '2 zabeležena obroka';
    if (count <= 4) return '$count zabeleženi obroki';
    return '$count zabeleženih obrokov';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        child: Row(
          children: [
            const Icon(Icons.restaurant_outlined, color: AppColors.meals),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Obroki',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    _label(today.mealsLogged),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            FilledButton.tonalIcon(
              onPressed: () {
                HapticFeedback.lightImpact();
                context.read<TrackingProvider>().logMeal();
              },
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Obrok'),
            ),
          ],
        ),
      ),
    );
  }
}
