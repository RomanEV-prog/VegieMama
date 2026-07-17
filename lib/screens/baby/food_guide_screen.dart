import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/helpers/l10n_ext.dart';
import '../../core/widgets/loading_state.dart';
import '../../core/widgets/veggie_mama_app_bar.dart';
import '../../models/food_introduction_model.dart';
import '../../providers/baby_provider.dart';
import 'widgets/child_disclaimer.dart';
import 'widgets/food_item_tile.dart';

class FoodGuideScreen extends StatefulWidget {
  const FoodGuideScreen({super.key});

  @override
  State<FoodGuideScreen> createState() => _FoodGuideScreenState();
}

class _FoodGuideScreenState extends State<FoodGuideScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<BabyProvider>();
      if (provider.foodGuide.isEmpty && !provider.isLoading) {
        provider.load();
      }
    });
  }

  /// Groups foods by their recommended starting month, ascending.
  Map<int, List<FoodIntroductionModel>> _byMonth(
      List<FoodIntroductionModel> foods) {
    final map = <int, List<FoodIntroductionModel>>{};
    for (final food in foods) {
      map.putIfAbsent(food.recommendedFromMonth, () => []).add(food);
    }
    return Map.fromEntries(
        map.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BabyProvider>();
    final babyMonths = provider.baby?.ageInMonths;

    return Scaffold(
      appBar:
          VeggieMamaAppBar(title: context.l10n.titleFoodGuide, showBack: true),
      body: Builder(
        builder: (context) {
          if (provider.isLoading && provider.foodGuide.isEmpty) {
            return const LoadingState(message: 'Pripravljam vodnik... 🌿');
          }

          final grouped = _byMonth(provider.foodGuide);

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            children: [
              Text(
                'Živila po starosti, izbrana za rastlinsko prehrano. '
                'Označi, kar je malček že poskusil — brez hitenja, '
                'vsak ima svoj tempo 💚',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              for (final entry in grouped.entries) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.sm),
                  child: Row(
                    children: [
                      Text(
                        'Od ${entry.key}. meseca',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      if (babyMonths != null &&
                          babyMonths >= entry.key) ...[
                        const SizedBox(width: AppSpacing.sm),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color:
                                AppColors.mintGreen.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'primerno zdaj',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.textPrimary),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                for (final food in entry.value)
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: FoodItemTile(food: food),
                  ),
                const SizedBox(height: AppSpacing.md),
              ],
              const ChildDisclaimer(),
            ],
          );
        },
      ),
    );
  }
}
