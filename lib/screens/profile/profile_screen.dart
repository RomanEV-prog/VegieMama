import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/helpers/emotional_feedback.dart';
import '../../core/helpers/l10n_ext.dart';
import '../../core/widgets/error_state.dart';
import '../../core/widgets/loading_state.dart';
import '../../core/widgets/veggie_mama_app_bar.dart';
import '../../providers/achievements_provider.dart';
import '../../providers/recipes_provider.dart';
import '../../providers/tracking_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/motivational_banner.dart';
import 'widgets/achievements_section.dart';
import 'widgets/ai_assistants_section.dart';
import 'widgets/baby_section.dart';
import 'widgets/favorite_recipes_section.dart';
import 'widgets/premium_status_card.dart';
import 'widgets/profile_header.dart';
import 'widgets/settings_preview_section.dart';
import 'widgets/tracking_summary.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Picked once (per stage) so the banner doesn't change on rebuilds.
  String? _motivationalMessage;

  Future<void> _refresh() async {
    await Future.wait([
      context.read<UserProvider>().loadUser(),
      context.read<TrackingProvider>().loadTodayData(),
      context.read<AchievementsProvider>().loadAchievements(),
      context.read<RecipesProvider>().loadRecipes(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    _motivationalMessage ??= EmotionalFeedback.motivationalMessage(
        userProvider.user?.userType.name);

    return Scaffold(
      appBar: VeggieMamaAppBar(title: context.l10n.navProfile),
      body: Builder(
        builder: (context) {
          if (userProvider.isLoading && userProvider.user == null) {
            return const LoadingState(message: 'Samo trenutek... 🌿');
          }
          if (userProvider.error != null && userProvider.user == null) {
            return ErrorState(
              error: userProvider.error!,
              onRetry: () => context.read<UserProvider>().loadUser(),
            );
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: AppSpacing.xl),
              children: [
                const ProfileHeader(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenPadding,
                  ),
                  child: MotivationalBanner(message: _motivationalMessage!),
                ),
                const SizedBox(height: AppSpacing.sm),
                const TrackingSummary(),
                const SizedBox(height: AppSpacing.lg),
                const BabySection(),
                const SizedBox(height: AppSpacing.lg),
                const AchievementsSection(),
                const SizedBox(height: AppSpacing.lg),
                const FavoriteRecipesSection(),
                const SizedBox(height: AppSpacing.lg),
                const AIAssistantsSection(),
                const SizedBox(height: AppSpacing.lg),
                const PremiumStatusCard(),
                const SizedBox(height: AppSpacing.lg),
                const SettingsPreviewSection(),
              ],
            ),
          );
        },
      ),
    );
  }
}
