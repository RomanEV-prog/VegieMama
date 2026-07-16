import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../models/tracking_data_model.dart';

/// Weekly water overview — gentle trend bars, no red warnings.
class WeeklyOverview extends StatelessWidget {
  final List<TrackingDataModel> weekData;

  const WeeklyOverview({super.key, required this.weekData});

  @override
  Widget build(BuildContext context) {
    if (weekData.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_view_week_outlined,
                    color: AppColors.mintGreen),
                const SizedBox(width: AppSpacing.sm),
                Text('Tvoj teden',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              height: 96,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (final day in weekData)
                    Expanded(child: _DayBar(day: day)),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Tekočine po dnevih. Vsak dan je svoja zgodba 🌿',
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

class _DayBar extends StatelessWidget {
  final TrackingDataModel day;

  const _DayBar({required this.day});

  static const _dayLabels = ['po', 'to', 'sr', 'če', 'pe', 'so', 'ne'];

  @override
  Widget build(BuildContext context) {
    final isToday = DateUtils.isSameDay(day.date, DateTime.now());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TweenAnimationBuilder<double>(
                tween: Tween(end: day.waterProgress.clamp(0.05, 1.0)),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                builder: (context, value, _) => FractionallySizedBox(
                  heightFactor: value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isToday
                          ? AppColors.water
                          : AppColors.water.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            _dayLabels[day.date.weekday - 1],
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isToday
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                  fontWeight: isToday ? FontWeight.w600 : FontWeight.normal,
                ),
          ),
        ],
      ),
    );
  }
}
