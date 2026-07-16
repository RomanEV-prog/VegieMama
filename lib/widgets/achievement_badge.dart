import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class AchievementBadge extends StatelessWidget {
  final String label;
  final bool isUnlocked;

  const AchievementBadge({
    super.key,
    required this.label,
    this.isUnlocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: isUnlocked
          ? AppColors.lavender.withValues(alpha: 0.4)
          : Theme.of(context).colorScheme.surface,
      avatar: isUnlocked
          ? const Icon(Icons.star, size: 16, color: AppColors.premiumGold)
          : null,
    );
  }
} 