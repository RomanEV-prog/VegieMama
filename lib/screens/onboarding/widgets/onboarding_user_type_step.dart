import 'package:flutter/material.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/helpers/l10n_ext.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../models/user_model.dart';

class OnboardingUserTypeStep extends StatelessWidget {
  final UserType selected;
  final ValueChanged<UserType> onChanged;

  const OnboardingUserTypeStep({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final options = [
      (UserType.pregnant, '🤰', context.l10n.onbTypePregnant,
          context.l10n.onbTypePregnantSub),
      (UserType.postpartum, '🌸', context.l10n.onbTypePostpartum,
          context.l10n.onbTypePostpartumSub),
      (UserType.babyMom, '🍼', context.l10n.onbTypeBaby,
          context.l10n.onbTypeBabySub),
      (UserType.toddlerMom, '🧸', context.l10n.onbTypeToddler,
          context.l10n.onbTypeToddlerSub),
    ];
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      children: [
        Text(
          context.l10n.onbTypeTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          context.l10n.onbTypeSubtitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.xl),
        for (final (type, emoji, title, subtitle) in options)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: InkWell(
              onTap: () => onChanged(type),
              borderRadius: AppRadius.cardRadius,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: selected == type
                      ? Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.15)
                      : Theme.of(context).colorScheme.surface,
                  borderRadius: AppRadius.cardRadius,
                  border: Border.all(
                    color: selected == type
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Text(emoji, style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style:
                                  Theme.of(context).textTheme.titleMedium),
                          Text(subtitle,
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                    if (selected == type)
                      Icon(Icons.check_circle,
                          color: Theme.of(context).colorScheme.primary),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
