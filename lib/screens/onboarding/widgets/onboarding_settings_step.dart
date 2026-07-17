import 'package:flutter/material.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/helpers/l10n_ext.dart';
import '../onboarding_screen.dart';

class OnboardingSettingsStep extends StatelessWidget {
  const OnboardingSettingsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      children: [
        Text(
          context.l10n.onbSettingsTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          context.l10n.onbSettingsSubtitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.xl),
        const OnboardingSettingsControls(),
      ],
    );
  }
}
