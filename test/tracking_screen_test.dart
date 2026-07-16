import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:veggiemama/providers/tracking_provider.dart';
import 'package:veggiemama/providers/user_provider.dart';
import 'package:veggiemama/screens/tracking/tracking_screen.dart';

Widget _buildTracking() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()..loadUser()),
      ChangeNotifierProvider(create: (_) => TrackingProvider()..loadTodayData()),
    ],
    child: const MaterialApp(home: TrackingScreen()),
  );
}

Future<void> _pumpLoaded(WidgetTester tester) async {
  await tester.pumpWidget(_buildTracking());
  await tester.pump(const Duration(milliseconds: 600));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 600));
  await tester.pump();
}

void main() {
  testWidgets('tracking screen shows all daily cards', (tester) async {
    await _pumpLoaded(tester);

    expect(find.text('Tekočine'), findsOneWidget);
    expect(find.text('Kako se počutiš?'), findsOneWidget);
    expect(find.text('Obroki'), findsOneWidget);
    // Mock user is pregnant, so breastfeeding stays hidden.
    expect(find.text('Dojenje'), findsNothing);

    await tester.scrollUntilVisible(
      find.text('Vitamini in dodatki'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Vitamini in dodatki'), findsOneWidget);
  });

  testWidgets('water quick add and meal log update the provider',
      (tester) async {
    await _pumpLoaded(tester);

    // Mock starts at 1250 ml.
    expect(find.textContaining('1.250 ml'), findsOneWidget);
    await tester.tap(find.text('500 ml'));
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.textContaining('1.750 ml'), findsOneWidget);

    expect(find.textContaining('2 zabeležena obroka'), findsOneWidget);
    await tester.tap(find.text('Obrok'));
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.textContaining('3 zabeleženi obroki'), findsOneWidget);
  });

  testWidgets('mood selection shows a gentle response', (tester) async {
    await _pumpLoaded(tester);

    // Mock starts at rating 4; pick a rating with a different message.
    await tester.tap(find.text('😐'));
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump(const Duration(milliseconds: 600));

    expect(
      find.text('Hvala, da si delila. Vsak dan je drugačen 💚'),
      findsOneWidget,
    );
  });

  testWidgets('vitamin chips toggle on and off', (tester) async {
    await _pumpLoaded(tester);

    final tracking = tester
        .element(find.byType(TrackingScreen))
        .read<TrackingProvider>();
    // Mock starts with B12, Železo, Vitamin D.
    expect(tracking.todayData!.vitamins, contains('B12'));

    await tester.scrollUntilVisible(
      find.text('Omega-3'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Omega-3'));
    await tester.pump(const Duration(milliseconds: 600));
    expect(tracking.todayData!.vitamins, contains('Omega-3'));

    await tester.tap(find.text('B12'));
    await tester.pump(const Duration(milliseconds: 600));
    expect(tracking.todayData!.vitamins, isNot(contains('B12')));
  });
}
