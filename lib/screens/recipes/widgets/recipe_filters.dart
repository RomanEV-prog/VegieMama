import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../providers/recipes_provider.dart';

/// Horizontal filter chips. Filter keys match the values used in
/// recipe tags / suitableFor / nutrientsHighlights.
class RecipeFilters extends StatelessWidget {
  const RecipeFilters({super.key});

  static const _filters = <(String label, String key)>[
    ('Nosečnost', 'nosečnost'),
    ('Dojenje', 'dojenje'),
    ('Uvajanje hrane', 'uvajanje hrane'),
    ('Malček 1–3', 'malček'),
    ('Železo', 'železo'),
    ('B12', 'B12'),
    ('Hitri obroki', 'hitro'),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RecipesProvider>();

    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding,
        ),
        children: [
          for (final (label, key) in _filters)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: FilterChip(
                label: Text(label),
                selected: provider.activeFilters.contains(key),
                onSelected: (_) {
                  HapticFeedback.selectionClick();
                  context.read<RecipesProvider>().toggleFilter(key);
                },
              ),
            ),
          if (provider.activeFilters.isNotEmpty)
            ActionChip(
              label: const Text('Počisti'),
              avatar: const Icon(Icons.close, size: 16),
              onPressed: () =>
                  context.read<RecipesProvider>().clearFilters(),
            ),
        ],
      ),
    );
  }
}
