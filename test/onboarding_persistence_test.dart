import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veggiemama/app.dart';
import 'package:veggiemama/models/user_model.dart';
import 'package:veggiemama/providers/tracking_provider.dart';
import 'package:veggiemama/services/repositories/user_repository.dart';
import 'helpers/test_env.dart';

void main() {
  // Hive init/close must run in the real zone (setUp), never inside the
  // FakeAsync test body. See .claude/commands/flutter-widget-testi.md.
  setUp(() async {
    await initTestEnv();
  });

  testWidgets('first launch shows onboarding and creates a persisted user',
      (tester) async {

    await tester.pumpWidget(const VeggieMamaApp());
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump();

    expect(find.text('Dobrodošla v VeggieMama'), findsOneWidget);

    // Step 1 → user type
    await tester.tap(find.text('Začniva 🌿'));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.tap(find.text('Mamica z malčkom'));
    await tester.pump();
    await tester.tap(find.text('Naprej'));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 400));

    // Step 2 → name (date skipped on purpose)
    await tester.enterText(find.byType(TextFormField).first, 'Maja');
    await tester.tap(find.text('Naprej'));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 400));

    // Step 3 → finish. createUser awaits a real Hive write — give the
    // real event loop time to complete it before pumping frames.
    await tester.tap(find.text('Konči'));
    await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 100)));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 400));

    // Redirect landed on Home.
    expect(find.text('Domov – skoraj tu 🌿'), findsOneWidget);

    // User persisted with the chosen data.
    final stored =
        await tester.runAsync(() => UserRepository().getCurrentUser());
    expect(stored, isNotNull);
    expect(stored!.firstName, 'Maja');
    expect(stored.userType, UserType.toddlerMom);
    expect(stored.onboardingCompleted, isTrue);
  });

  testWidgets('returning user skips onboarding', (tester) async {
    // Seed writes are small — they complete fine via runAsync.
    await tester.runAsync(() => seedUser(testUser()));

    await tester.pumpWidget(const VeggieMamaApp());
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump();

    expect(find.text('Dobrodošla v VeggieMama'), findsNothing);
    expect(find.text('Domov – skoraj tu 🌿'), findsOneWidget);
  });

  test('tracking mutations survive a provider restart', () async {
    await seedUser(testUser());
    await seedToday(testToday());

    final first = TrackingProvider();
    await first.loadTodayData();
    first.addWaterIntake(500);
    first.logMeal();
    // Persistence runs in the background — give it a beat.
    await Future<void>.delayed(const Duration(milliseconds: 50));

    final second = TrackingProvider();
    await second.loadTodayData();
    expect(second.todayData!.waterIntake, 1750);
    expect(second.todayData!.mealsLogged, 3);
  });
}
