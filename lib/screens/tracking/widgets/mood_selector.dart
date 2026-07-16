import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/helpers/emotional_feedback.dart';
import '../../../providers/tracking_provider.dart';

/// Gentle 1–5 mood selector — an observation, never a grade.
class MoodSelector extends StatelessWidget {
  final int currentRating;

  const MoodSelector({super.key, required this.currentRating});

  static const _moods = ['😔', '😕', '😐', '🙂', '😊'];

  void _select(BuildContext context, int rating) {
    HapticFeedback.selectionClick();
    context.read<TrackingProvider>().setMood(rating);
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
                const Icon(Icons.spa_outlined, color: AppColors.mood),
                const SizedBox(width: AppSpacing.sm),
                Text('Kako se počutiš?',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (var i = 1; i <= 5; i++)
                  _MoodOption(
                    emoji: _moods[i - 1],
                    selected: currentRating == i,
                    onTap: () => _select(context, i),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              switchInCurve: Curves.easeOutCubic,
              child: Text(
                EmotionalFeedback.moodResponse(currentRating),
                key: ValueKey(currentRating),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoodOption extends StatelessWidget {
  final String emoji;
  final bool selected;
  final VoidCallback onTap;

  const _MoodOption({
    required this.emoji,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected
              ? AppColors.mood.withValues(alpha: 0.25)
              : Colors.transparent,
        ),
        child: AnimatedScale(
          scale: selected ? 1.2 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: Text(emoji, style: const TextStyle(fontSize: 28)),
        ),
      ),
    );
  }
}
