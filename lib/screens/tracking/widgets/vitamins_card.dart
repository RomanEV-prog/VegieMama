import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../models/tracking_data_model.dart';
import '../../../providers/tracking_provider.dart';

/// Vitamins & supplements as toggle chips — key nutrients for a
/// plant-based pregnancy and early motherhood.
class VitaminsCard extends StatelessWidget {
  final TrackingDataModel today;

  const VitaminsCard({super.key, required this.today});

  static const _options = [
    'B12',
    'Železo',
    'Vitamin D',
    'Omega-3',
    'Jod',
    'Kalcij',
    'Folna kislina',
  ];

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
                const Icon(Icons.eco_outlined, color: AppColors.vitamins),
                const SizedBox(width: AppSpacing.sm),
                Text('Vitamini in dodatki',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final vitamin in _options)
                  FilterChip(
                    label: Text(vitamin),
                    selected: today.vitamins.contains(vitamin),
                    selectedColor:
                        AppColors.vitamins.withValues(alpha: 0.25),
                    checkmarkColor: AppColors.textPrimary,
                    onSelected: (_) {
                      HapticFeedback.selectionClick();
                      context.read<TrackingProvider>().toggleVitamin(vitamin);
                    },
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Označi, kar si danes vzela. Nič ni obvezno 🌿',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
