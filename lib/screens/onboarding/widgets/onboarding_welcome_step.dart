import 'package:flutter/material.dart';
import '../../../core/constants/app_spacing.dart';

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
            'Dobrodošla v VeggieMama',
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Tvoja nežna spremljevalka na rastlinski poti — '
            'od nosečnosti do malčkovih prvih let.\n\n'
            'Brez pritiska, brez ocenjevanja. Samo podpora.',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
