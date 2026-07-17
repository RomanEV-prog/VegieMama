import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../helpers/l10n_ext.dart';

/// Loading state widget with gentle messaging
class LoadingState extends StatelessWidget {
  final String? message;

  const LoadingState({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.mintGreen),
          ),
          const SizedBox(height: 16),
          Text(
            message ?? context.l10n.commonLoading,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
