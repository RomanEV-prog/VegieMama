import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../models/tracking_data_model.dart';
import '../../../providers/tracking_provider.dart';

/// Breastfeeding / feeding sessions — shown only for postpartum
/// and baby stages.
class BreastfeedingCard extends StatelessWidget {
  final TrackingDataModel today;

  const BreastfeedingCard({super.key, required this.today});

  String _label(int count) {
    if (count == 0) return 'Danes še ni zabeleženih podojev';
    if (count == 1) return '1 podoj';
    if (count == 2) return '2 podoja';
    if (count <= 4) return '$count podoji';
    return '$count podojev';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        child: Row(
          children: [
            const Icon(Icons.child_care_outlined, color: AppColors.lavender),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dojenje',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    _label(today.breastfeedingSessions),
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
                context.read<TrackingProvider>().logBreastfeeding();
              },
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Podoj'),
            ),
          ],
        ),
      ),
    );
  }
}
