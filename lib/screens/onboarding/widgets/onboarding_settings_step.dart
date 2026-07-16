import 'package:flutter/material.dart';
import '../../../core/constants/app_spacing.dart';
import '../onboarding_screen.dart';

class OnboardingSettingsStep extends StatelessWidget {
  const OnboardingSettingsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      children: [
        Text(
          'Še zadnji dotik',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Izberi jezik in videz. Oboje lahko kadar koli spremeniš v nastavitvah.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.xl),
        const OnboardingSettingsControls(),
      ],
    );
  }
}
