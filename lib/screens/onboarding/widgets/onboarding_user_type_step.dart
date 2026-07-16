import 'package:flutter/material.dart';
import '../../../core/constants/app_radius.dart';
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

  static const _options = [
    (UserType.pregnant, '🤰', 'Nosečnica', 'Pričakujem otroka'),
    (UserType.postpartum, '🌸', 'Po porodu', 'Okrevam in se privajam'),
    (UserType.babyMom, '🍼', 'Mamica z dojenčkom', 'Otrok do 1. leta'),
    (UserType.toddlerMom, '🧸', 'Mamica z malčkom', 'Otrok od 1 do 3 let'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      children: [
        Text(
          'Kje na poti si?',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Aplikacijo prilagodim tvojemu obdobju. Kadar koli lahko to spremeniš.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.xl),
        for (final (type, emoji, title, subtitle) in _options)
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
