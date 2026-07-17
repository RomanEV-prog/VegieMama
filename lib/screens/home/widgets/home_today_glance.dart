import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/helpers/emotional_feedback.dart';
import '../../../core/helpers/format_helper.dart';
import '../../../providers/tracking_provider.dart';

/// A soft glance at today's water intake with a path into tracking.
class HomeTodayGlance extends StatelessWidget {
  const HomeTodayGlance({super.key});

  @override
  Widget build(BuildContext context) {
    final today = context.watch<TrackingProvider>().todayData;
    if (today == null) return const SizedBox.shrink();

    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => context.go('/tracking'),
        borderRadius: AppRadius.cardRadius,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.water_drop_outlined,
                      color: AppColors.water, size: 20),
                  const SizedBox(width: AppSpacing.sm),
                  Text('Danes',
                      style: Theme.of(context).textTheme.titleMedium),
                  const Spacer(),
                  Text(
                    FormatHelper.waterAmount(today.waterIntake),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                child: LinearProgressIndicator(
                  value: today.waterProgress,
                  minHeight: 6,
                  color: AppColors.water,
                  backgroundColor: AppColors.water.withValues(alpha: 0.15),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                EmotionalFeedback.waterProgress(today.waterProgress),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
