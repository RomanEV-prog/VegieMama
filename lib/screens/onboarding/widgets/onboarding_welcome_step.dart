import 'package:flutter/material.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/helpers/l10n_ext.dart';

class OnboardingWelcomeStep extends StatelessWidget {
  const OnboardingWelcomeStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🌿', style: TextStyle(fontSize: 64)),
          const SizedBox(height: AppSpacing.xl),
          Text(
            context.l10n.onbWelcomeTitle,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            context.l10n.onbWelcomeBody,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
