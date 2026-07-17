import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/helpers/date_helper.dart';
import '../../../models/user_model.dart';
import '../../../providers/baby_provider.dart';
import '../../../providers/user_provider.dart';

/// The Home highlight card, tailored to the user's current stage:
/// pregnancy week for expecting moms, child entry point otherwise.
class HomeStageHighlight extends StatelessWidget {
  const HomeStageHighlight({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    if (user == null) return const SizedBox.shrink();

    switch (user.userType) {
      case UserType.pregnant:
        return _HighlightCard(
          emoji: '🤰',
          title: user.dueDate != null
              ? DateHelper.pregnancyWeekDisplay(user.dueDate!)
              : 'Tvoja nosečnost',
          subtitle: user.dueDate != null
              ? '${DateHelper.trimester(user.dueDate!)}. trimesečje · vsak teden šteje 💚'
              : 'V profilu dodaj PDP za spremljanje po tednih.',
          onTap: () => context.go('/profile'),
        );
      case UserType.postpartum:
        return _HighlightCard(
          emoji: '🌸',
          title: 'Nežno okrevanje',
          subtitle:
              'Tvoje telo je opravilo nekaj izjemnega. Počivaj, ko lahko.',
          onTap: () => context.go('/tracking'),
        );
      case UserType.babyMom:
      case UserType.toddlerMom:
        final baby = context.watch<BabyProvider>().baby;
        final name =
            (baby?.name.isNotEmpty ?? false) ? baby!.name : 'Tvoj otrok';
        return _HighlightCard(
          emoji: user.userType == UserType.babyMom ? '🍼' : '🧸',
          title: name,
          subtitle: baby != null
              ? '${DateHelper.babyAgeDisplay(baby.birthDate)} · profil, uvajanje hrane in vodnik'
              : (user.birthDate != null
                  ? '${DateHelper.babyAgeDisplay(user.birthDate!)} · odpri profil otroka'
                  : 'Odpri profil otroka in vodnik uvajanja hrane'),
          onTap: () => context.push('/baby'),
        );
    }
  }
}

class _HighlightCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _HighlightCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.cardRadius,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        decoration: BoxDecoration(
          color: AppColors.mintGreen.withValues(alpha: 0.15),
          borderRadius: AppRadius.cardRadius,
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }
}
