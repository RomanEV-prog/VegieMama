import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/helpers/date_helper.dart';
import '../../../models/user_model.dart';
import '../../../providers/user_provider.dart';

/// Profile header: avatar, name and the user's current life stage.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  String _stageText(UserModel user) {
    switch (user.userType) {
      case UserType.pregnant:
        if (user.dueDate != null) {
          final week = DateHelper.pregnancyWeekDisplay(user.dueDate!);
          final trimester = DateHelper.trimester(user.dueDate!);
          return '$week · $trimester. trimesečje';
        }
        return 'Nosečnica';
      case UserType.postpartum:
        return 'Mamica po porodu';
      case UserType.babyMom:
        if (user.birthDate != null) {
          return 'Dojenček: ${DateHelper.babyAgeDisplay(user.birthDate!)}';
        }
        return 'Mamica z dojenčkom';
      case UserType.toddlerMom:
        if (user.birthDate != null) {
          return 'Malček: ${DateHelper.babyAgeDisplay(user.birthDate!)}';
        }
        return 'Mamica z malčkom';
    }
  }

  String _initials(UserModel user) {
    final first = user.firstName.isNotEmpty ? user.firstName[0] : '';
    final last = user.lastName.isNotEmpty ? user.lastName[0] : '';
    return '$first$last'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    if (user == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
        vertical: AppSpacing.lg,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: AppColors.mintGreen.withValues(alpha: 0.2),
            child: Text(
              _initials(user),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.mintGreen,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  _stageText(user),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          if (user.isPremium)
            const Icon(Icons.star_rounded, color: AppColors.premiumGold),
        ],
      ),
    );
  }
}
