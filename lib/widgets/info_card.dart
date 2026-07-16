import 'package:flutter/material.dart';
import '../core/constants/app_radius.dart';
import '../core/constants/app_spacing.dart';

/// Generic info card used across screens
class InfoCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final EdgeInsets? padding;

  const InfoCard({
    super.key,
    this.title,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: AppRadius.cardRadius),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppSpacing.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(title!, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
            ],
            child,
          ],
        ),
      ),
    );
  }
}
