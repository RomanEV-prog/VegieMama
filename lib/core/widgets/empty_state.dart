import 'package:flutter/material.dart';
import '../helpers/l10n_ext.dart';

/// Empty state widget with gentle messaging
class EmptyState extends StatelessWidget {
  final String? message;
  final IconData icon;

  const EmptyState({
    super.key,
    this.message,
    this.icon = Icons.spa_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(height: 16),
          Text(
            message ?? context.l10n.commonEmpty,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
