import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/helpers/format_helper.dart';
import '../../../providers/user_provider.dart';

/// Gentle premium status display — informative, never pushy.
class PremiumStatusCard extends StatelessWidget {
  const PremiumStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    if (user == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
      ),
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: user.isPremium
            ? AppColors.premiumGoldLight
            : AppColors.lavender.withValues(alpha: 0.15),
        borderRadius: AppRadius.cardRadius,
      ),
      child: Row(
        children: [
          Icon(
            user.isPremium ? Icons.star_rounded : Icons.star_outline_rounded,
            color: AppColors.premiumGold,
            size: 32,
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.isPremium ? 'Premium članica' : 'VeggieMama Premium',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  user.isPremium
                      ? (user.premiumUntil != null
                          ? 'Aktivno do ${FormatHelper.shortDate(user.premiumUntil!)}'
                          : 'Hvala, da si z nami 💛')
                      : 'Več podpore, ko jo boš želela. Brez hitenja.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
