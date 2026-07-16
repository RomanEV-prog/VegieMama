import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/helpers/emotional_feedback.dart';
import '../../../core/helpers/format_helper.dart';
import '../../../providers/tracking_provider.dart';

/// Daily tracking summary with a gentle water quick add.
/// Stateful only for the button press animation; all domain data
/// comes from [TrackingProvider].
class TrackingSummary extends StatefulWidget {
  const TrackingSummary({super.key});

  @override
  State<TrackingSummary> createState() => _TrackingSummaryState();
}

class _TrackingSummaryState extends State<TrackingSummary> {
  bool _buttonPressed = false;

  static const _moodEmojis = ['😔', '😕', '😐', '🙂', '😊'];

  void _addWater() {
    HapticFeedback.lightImpact();
    context.read<TrackingProvider>().addWaterIntake(250);
    setState(() => _buttonPressed = true);
    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) setState(() => _buttonPressed = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackingProvider>(
      builder: (context, tracking, _) {
        final today = tracking.todayData;
        if (today == null) return const SizedBox.shrink();

        return Card(
          margin: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tvoj dan',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.lg),

                // Water progress
                Row(
                  children: [
                    const Icon(Icons.water_drop_outlined,
                        color: AppColors.water, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      FormatHelper.waterAmount(today.waterIntake),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      ' / ${FormatHelper.waterAmount(today.waterGoal)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    const Spacer(),
                    AnimatedScale(
                      scale: _buttonPressed ? 0.92 : 1.0,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeOutCubic,
                      child: FilledButton.tonalIcon(
                        onPressed: _addWater,
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('250 ml'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                TweenAnimationBuilder<double>(
                  tween: Tween(end: today.waterProgress),
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, _) => ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    child: LinearProgressIndicator(
                      value: value,
                      minHeight: 8,
                      color: AppColors.water,
                      backgroundColor:
                          AppColors.water.withValues(alpha: 0.15),
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

                // Mini stats row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _MiniStat(
                      icon: Icons.restaurant_outlined,
                      color: AppColors.meals,
                      value: '${today.mealsLogged}',
                      label: 'obroki',
                    ),
                    _MiniStat(
                      emoji: _moodEmojis[
                          (today.moodRating - 1).clamp(0, 4)],
                      color: AppColors.mood,
                      value: '',
                      label: 'počutje',
                    ),
                    _MiniStat(
                      icon: Icons.bedtime_outlined,
                      color: AppColors.sleep,
                      value: FormatHelper.sleepHours(today.sleepHours),
                      label: 'spanje',
                    ),
                    _MiniStat(
                      icon: Icons.eco_outlined,
                      color: AppColors.vitamins,
                      value: '${today.vitamins.length}',
                      label: 'vitamini',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MiniStat extends StatelessWidget {
  final IconData? icon;
  final String? emoji;
  final Color color;
  final String value;
  final String label;

  const _MiniStat({
    this.icon,
    this.emoji,
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (emoji != null)
          Text(emoji!, style: const TextStyle(fontSize: 20))
        else
          Icon(icon, color: color, size: 20),
        const SizedBox(height: AppSpacing.xs),
        if (value.isNotEmpty)
          Text(value, style: Theme.of(context).textTheme.titleMedium),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }
}
