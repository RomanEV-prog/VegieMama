import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/app_colors.dart';
import '../core/helpers/l10n_ext.dart';
import '../providers/user_provider.dart';
import '../screens/home/home_screen.dart';
import '../screens/tracking/tracking_screen.dart';
import '../screens/recipes/recipes_screen.dart';
import '../screens/recipes/recipe_detail_screen.dart';
import '../screens/ai_assistant/ai_assistant_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/baby/baby_profile_screen.dart';
import '../screens/baby/food_guide_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

/// Builds the app router. Requires the [UserProvider] instance so the
/// redirect can gate everything behind onboarding.
GoRouter createAppRouter(UserProvider userProvider) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    refreshListenable: userProvider,
    redirect: (context, state) {
      // While the user is still loading, stay put (screens show loaders).
      if (userProvider.isLoading) return null;

      final completed = userProvider.onboardingCompleted;
      final onOnboarding = state.uri.path == '/onboarding';

      if (!completed && !onOnboarding) return '/onboarding';
      if (completed && onOnboarding) return '/';
      return null;
    },
    routes: [
      // Onboarding (outside shell)
      GoRoute(
        path: '/onboarding',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Settings (outside shell, has back button)
      GoRoute(
        path: '/settings',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SettingsScreen(),
      ),

      // Baby profile + food guide (outside shell, have back buttons)
      GoRoute(
        path: '/baby',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const BabyProfileScreen(),
      ),
      GoRoute(
        path: '/baby/food-guide',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const FoodGuideScreen(),
      ),

      // Recipe detail (outside shell, has back button)
      GoRoute(
        path: '/recipes/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => RecipeDetailScreen(
          recipeId: state.pathParameters['id']!,
        ),
      ),

      // Main shell with bottom navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => _ShellScaffold(child: child),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/tracking',
            builder: (context, state) => const TrackingScreen(),
          ),
          GoRoute(
            path: '/recipes',
            builder: (context, state) => const RecipesScreen(),
          ),
          GoRoute(
            path: '/ai',
            builder: (context, state) => const AIAssistantScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
}

/// Shell scaffold with persistent bottom navigation
class _ShellScaffold extends StatelessWidget {
  final Widget child;
  const _ShellScaffold({required this.child});

  static const _tabs = ['/', '/tracking', '/recipes', '/ai', '/profile'];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final index = _tabs.indexOf(location);
    return index >= 0 ? index : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex(context),
        onTap: (index) => context.go(_tabs[index]),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.mintGreen,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home_outlined), activeIcon: const Icon(Icons.home), label: context.l10n.navHome),
          BottomNavigationBarItem(icon: const Icon(Icons.show_chart_outlined), activeIcon: const Icon(Icons.show_chart), label: context.l10n.navTracking),
          BottomNavigationBarItem(icon: const Icon(Icons.restaurant_outlined), activeIcon: const Icon(Icons.restaurant), label: context.l10n.navRecipes),
          BottomNavigationBarItem(icon: const Icon(Icons.smart_toy_outlined), activeIcon: const Icon(Icons.smart_toy), label: context.l10n.navAI),
          BottomNavigationBarItem(icon: const Icon(Icons.person_outline), activeIcon: const Icon(Icons.person), label: context.l10n.navProfile),
        ],
      ),
    );
  }
}
