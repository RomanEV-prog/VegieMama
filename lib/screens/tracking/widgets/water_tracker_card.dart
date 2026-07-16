import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/helpers/emotional_feedback.dart';
import '../../../core/helpers/format_helper.dart';
import '../../../models/tracking_data_model.dart';
import '../../../providers/tracking_provider.dart';

/// Water tracking card with animated progress and quick add buttons.
class WaterTrackerCard extends StatelessWidget {
  final TrackingDataModel today;

  const WaterTrackerCard({super.key, required this.today});

  void _add(BuildContext context, int ml) {
    HapticFeedback.lightImpact();
    context.read<TrackingProvider>().addWaterIntake(ml);
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
                const Icon(Icons.water_drop_outlined,
                    color: AppColors.water),
                const SizedBox(width: AppSpacing.sm),
                Text('Tekočine',
                    style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                Text(
                  '${FormatHelper.waterAmount(today.waterIntake)} / ${FormatHelper.waterAmount(today.waterGoal)}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            TweenAnimationBuilder<double>(
              tween: Tween(end: today.waterProgress),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              builder: (context, value, _) => ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 10,
                  color: AppColors.water,
                  backgroundColor: AppColors.water.withValues(alpha: 0.15),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              EmotionalFeedback.waterProgress(today.waterProgress),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: FilledButton.tonalIcon(
                    onPressed: () => _add(context, 250),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('250 ml'),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: FilledButton.tonalIcon(
                    onPressed: () => _add(context, 500),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('500 ml'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
