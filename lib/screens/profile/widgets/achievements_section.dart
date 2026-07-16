import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../models/achievement_model.dart';
import '../../../providers/achievements_provider.dart';
import '../../../widgets/section_title.dart';

/// Horizontal list of achievements with gentle progress rings.
class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AchievementsProvider>(
      builder: (context, provider, _) {
        if (provider.achievements.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'Tvoji dosežki'),
            SizedBox(
              height: 120,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: provider.achievements.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: AppSpacing.md),
                itemBuilder: (context, index) =>
                    _AchievementItem(achievement: provider.achievements[index]),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AchievementItem extends StatelessWidget {
  final AchievementModel achievement;

  const _AchievementItem({required this.achievement});

  @override
  Widget build(BuildContext context) {
    final unlocked = achievement.isUnlocked;

    return SizedBox(
      width: 88,
      child: Opacity(
        opacity: unlocked ? 1.0 : 0.6,
        child: Column(
          children: [
            SizedBox(
              width: 56,
              height: 56,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: achievement.progress,
                    strokeWidth: 3,
                    color: unlocked
                        ? AppColors.premiumGold
                        : AppColors.mintGreen,
                    backgroundColor:
                        AppColors.mintGreen.withValues(alpha: 0.12),
                  ),
                  Text(achievement.icon,
                      style: const TextStyle(fontSize: 24)),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              achievement.title,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
