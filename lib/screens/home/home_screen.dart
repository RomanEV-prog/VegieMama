import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/helpers/emotional_feedback.dart';
import '../../core/helpers/l10n_ext.dart';
import '../../core/widgets/veggie_mama_app_bar.dart';
import '../../providers/user_provider.dart';
import '../../widgets/motivational_banner.dart';
import 'widgets/home_stage_highlight.dart';
import 'widgets/home_today_glance.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Picked once (per stage) so the banner doesn't change on rebuilds.
  String? _motivationalMessage;

  String _greeting(String name) {
    final hour = DateTime.now().hour;
    if (hour < 10) return EmotionalFeedback.morningGreeting(name);
    if (hour >= 19) return EmotionalFeedback.eveningMessage(name);
    return 'Živjo, $name 💚';
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    _motivationalMessage ??=
        EmotionalFeedback.motivationalMessage(user?.userType.name);

    return Scaffold(
      appBar: VeggieMamaAppBar(title: context.l10n.navHome),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        children: [
          if (user != null) ...[
            Text(
              _greeting(user.firstName),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          MotivationalBanner(message: _motivationalMessage!),
          const SizedBox(height: AppSpacing.md),
          const HomeStageHighlight(),
          const SizedBox(height: AppSpacing.md),
          const HomeTodayGlance(),
          const SizedBox(height: AppSpacing.md),

          // Quick shortcuts
          Row(
            children: [
              Expanded(
                child: _ShortcutCard(
                  emoji: '💧',
                  label: 'Sledenje',
                  onTap: () => context.go('/tracking'),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _ShortcutCard(
                  emoji: '🥗',
                  label: 'Recepti',
                  onTap: () => context.go('/recipes'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShortcutCard extends StatelessWidget {
  final String emoji;
  final String label;
  final VoidCallback onTap;

  const _ShortcutCard({
    required this.emoji,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(height: AppSpacing.sm),
              Text(label, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}
