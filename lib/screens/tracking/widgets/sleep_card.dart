import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/helpers/format_helper.dart';
import '../../../models/tracking_data_model.dart';
import '../../../providers/tracking_provider.dart';

/// Sleep hours card with a one-hand friendly slider.
class SleepCard extends StatelessWidget {
  final TrackingDataModel today;

  const SleepCard({super.key, required this.today});

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
                const Icon(Icons.bedtime_outlined, color: AppColors.sleep),
                const SizedBox(width: AppSpacing.sm),
                Text('Spanje',
                    style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                Text(
                  FormatHelper.sleepHours(today.sleepHours),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Slider(
              value: today.sleepHours.clamp(0, 12),
              min: 0,
              max: 12,
              divisions: 24,
              activeColor: AppColors.sleep,
              onChanged: (value) =>
                  context.read<TrackingProvider>().setSleep(value),
            ),
            Text(
              'Vsaka ura počitka šteje 💜',
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
