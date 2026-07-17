import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:veggiemama/l10n/app_localizations.dart';
import 'package:veggiemama/providers/achievements_provider.dart';
import 'package:veggiemama/providers/ai_chat_provider.dart';
import 'package:veggiemama/providers/baby_provider.dart';
import 'package:veggiemama/providers/locale_provider.dart';
import 'package:veggiemama/providers/recipes_provider.dart';
import 'package:veggiemama/providers/theme_provider.dart';
import 'package:veggiemama/providers/tracking_provider.dart';
import 'package:veggiemama/providers/user_provider.dart';
import 'package:veggiemama/screens/profile/profile_screen.dart';
import 'helpers/test_env.dart';

Widget _buildProfile() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()..loadUser()),
      ChangeNotifierProvider(create: (_) => TrackingProvider()..loadTodayData()),
      ChangeNotifierProvider(
          create: (_) => AchievementsProvider()..loadAchievements()),
      ChangeNotifierProvider(create: (_) => RecipesProvider()..loadRecipes()),
      ChangeNotifierProvider(create: (_) => AIChatProvider()..loadAssistants()),
      ChangeNotifierProvider(create: (_) => BabyProvider()..load()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => LocaleProvider()),
    ],
    child: const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('sl'),
      home: ProfileScreen(),
    ),
  );
}

void main() {
  setUp(() async {
    await initTestEnv(user: testUser(), today: testToday());
  });

  testWidgets('profile shows mock user, tracking and achievements',
      (tester) async {
    await tester.pumpWidget(_buildProfile());
    // Let the mock services finish their simulated delays.
    // First round: user loads and the list appears; second round: the
    // lazily-created providers (tracking, recipes...) finish their mocks.
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();

    expect(find.text('Ana Novak'), findsOneWidget);
    expect(find.text('Tvoj dan'), findsOneWidget);
    expect(find.text('Tvoji dosežki'), findsOneWidget);
    // Lower sections live below the fold of the test viewport.
    await tester.scrollUntilVisible(
      find.text('Najljubši recepti'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Najljubši recepti'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Premium članica'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.text('Premium članica'), findsOneWidget);
  });

  testWidgets('water quick add increases intake via TrackingProvider',
      (tester) async {
    await tester.pumpWidget(_buildProfile());
    // First round: user loads and the list appears; second round: the
    // lazily-created providers (tracking, recipes...) finish their mocks.
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();

    // Mock starts at 1250 ml.
    expect(find.textContaining('1.250 ml'), findsOneWidget);

    await tester.tap(find.text('250 ml'));
    // First round: user loads and the list appears; second round: the
    // lazily-created providers (tracking, recipes...) finish their mocks.
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();

    expect(find.textContaining('1.500 ml'), findsOneWidget);
  });
}
