import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/widgets/error_state.dart';
import '../../core/widgets/loading_state.dart';
import '../../core/widgets/veggie_mama_app_bar.dart';
import '../../models/user_model.dart';
import '../../providers/tracking_provider.dart';
import '../../providers/user_provider.dart';
import 'widgets/baby_meals_card.dart';
import 'widgets/breastfeeding_card.dart';
import 'widgets/meals_card.dart';
import 'widgets/mood_selector.dart';
import 'widgets/sleep_card.dart';
import 'widgets/vitamins_card.dart';
import 'widgets/water_tracker_card.dart';
import 'widgets/weekly_overview.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  @override
  void initState() {
    super.initState();
    // Week data isn't loaded at app start — fetch it when the screen opens.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<TrackingProvider>().loadWeekData();
    });
  }

  Future<void> _refresh() async {
    final tracking = context.read<TrackingProvider>();
    await Future.wait([
      tracking.loadTodayData(),
      tracking.loadWeekData(),
    ]);
  }

  bool _showBreastfeeding(UserType? type) =>
      type == UserType.postpartum || type == UserType.babyMom;

  @override
  Widget build(BuildContext context) {
    final tracking = context.watch<TrackingProvider>();
    final userType = context.watch<UserProvider>().userType;
    final today = tracking.todayData;

    return Scaffold(
      appBar: const VeggieMamaAppBar(title: 'Sledenje'),
      body: Builder(
        builder: (context) {
          if (tracking.isLoading && today == null) {
            return const LoadingState(message: 'Samo trenutek... 🌿');
          }
          if (tracking.error != null && today == null) {
            return ErrorState(
              error: tracking.error!,
              onRetry: () => context.read<TrackingProvider>().loadTodayData(),
            );
          }
          if (today == null) return const SizedBox.shrink();

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              children: [
                WaterTrackerCard(today: today),
                const SizedBox(height: AppSpacing.md),
                MoodSelector(currentRating: today.moodRating),
                const SizedBox(height: AppSpacing.md),
                MealsCard(today: today),
                const SizedBox(height: AppSpacing.md),
                if (_showBreastfeeding(userType)) ...[
                  BreastfeedingCard(today: today),
                  const SizedBox(height: AppSpacing.md),
                ],
                if (userType == UserType.babyMom ||
                    userType == UserType.toddlerMom) ...[
                  BabyMealsCard(
                    today: today,
                    showNutrients: userType == UserType.toddlerMom,
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                SleepCard(today: today),
                const SizedBox(height: AppSpacing.md),
                VitaminsCard(today: today),
                const SizedBox(height: AppSpacing.md),
                WeeklyOverview(weekData: tracking.weekData),
              ],
            ),
          );
        },
      ),
    );
  }
}
