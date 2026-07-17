import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../models/baby_profile_model.dart';

/// Gentle description of the child's current stage.
class BabyStageCard extends StatelessWidget {
  final BabyProfileModel baby;

  const BabyStageCard({super.key, required this.baby});

  (String, String, String) get _stageInfo {
    switch (baby.stage) {
      case BabyStage.newborn:
        return (
          '🌙',
          'Novorojenček',
          'Mleko (materino ali obogateno) je zdaj vsa hrana, ki jo '
              'otrok potrebuje. Uvajanje goste hrane pride okoli 6. meseca.',
        );
      case BabyStage.introducing:
        return (
          '🥄',
          'Uvajanje hrane',
          'Čas prvih žličk! Uvajaj počasi, eno živilo naenkrat, brez '
              'hitenja. Mleko ostaja glavni vir hranil do 1. leta.',
        );
      case BabyStage.toddler:
        return (
          '🧸',
          'Malček',
          'Malček je vse bolj del družinske mize. Pri rastlinski prehrani '
              'so posebej pomembni B12, železo, kalcij, jod in omega-3. '
              'Izbirčnost je normalna faza — brez skrbi.',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final (emoji, title, description) = _stageInfo;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.mintGreen.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSpacing.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: AppSpacing.sm),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(description, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
