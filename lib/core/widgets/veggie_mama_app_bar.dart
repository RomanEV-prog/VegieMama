import 'package:flutter/material.dart';
import '../constants/app_radius.dart';

/// Consistent app bar for VeggieMama screens
class VeggieMamaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBack;

  const VeggieMamaAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      automaticallyImplyLeading: showBack,
      actions: actions,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.appBarRadius,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
