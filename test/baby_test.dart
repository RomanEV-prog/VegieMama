import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:veggiemama/l10n/app_localizations.dart';
import 'package:veggiemama/models/baby_profile_model.dart';
import 'package:veggiemama/models/user_model.dart';
import 'package:veggiemama/providers/baby_provider.dart';
import 'package:veggiemama/providers/user_provider.dart';
import 'package:veggiemama/screens/baby/baby_profile_screen.dart';
import 'package:veggiemama/screens/baby/food_guide_screen.dart';
import 'helpers/test_env.dart';

UserModel _toddlerUser() => testUser().copyWith(
      userType: UserType.toddlerMom,
      birthDate: DateTime.now().subtract(const Duration(days: 18 * 30)),
    );

Widget _wrap(Widget screen) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()..loadUser()),
      ChangeNotifierProvider(create: (_) => BabyProvider()..load()),
    ],
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('sl'),
      home: screen,
    ),
  );
}

void main() {
  setUp(() async {
    await initTestEnv(user: _toddlerUser());
    await seedBaby(BabyProfileModel(
      id: 'b1',
      name: '',
      birthDate: DateTime.now().subtract(const Duration(days: 18 * 30)),
    ));
  });

  test('baby stage derives from age', () {
    final now = DateTime.now();
    BabyProfileModel babyAt(int months) => BabyProfileModel(
          id: 'b',
          name: 'Test',
          birthDate: DateTime(now.year, now.month - months, now.day),
        );

    expect(babyAt(2).stage, BabyStage.newborn);
    expect(babyAt(7).stage, BabyStage.introducing);
    expect(babyAt(18).stage, BabyStage.toddler);
  });

  testWidgets('baby profile creates itself from user birth date',
      (tester) async {
    await tester.pumpWidget(_wrap(const BabyProfileScreen()));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();

    expect(find.text('Tvoj malček'), findsOneWidget);
    expect(find.text('Malček'), findsOneWidget); // stage card title
    expect(find.text('Vodnik uvajanja hrane'), findsOneWidget);
    expect(find.textContaining('ne nadomeščajo nasveta pediatra'),
        findsOneWidget);
  });

  testWidgets('food guide groups by month and marks introduced',
      (tester) async {
    await tester.pumpWidget(_wrap(const FoodGuideScreen()));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();

    expect(find.text('Od 6. meseca'), findsOneWidget);
    expect(find.text('Korenje'), findsOneWidget);
    // Toddler (18 m) → month-6 group is age-appropriate.
    expect(find.text('primerno zdaj'), findsWidgets);

    final provider = tester
        .element(find.byType(FoodGuideScreen))
        .read<BabyProvider>();

    // Mark the first food as introduced via its checkbox.
    await tester.tap(find.byType(Checkbox).first);
    await tester.pump();
    expect(provider.introducedCount, 1);

    // Reaction chips appear for introduced foods.
    expect(find.text('🙂 V redu'), findsOneWidget);
    await tester.tap(find.text('🙂 V redu'));
    await tester.pump();
    expect(
      provider.foodGuide.firstWhere((f) => f.introduced).reaction,
      'ok',
    );
  });

  test('food introduction progress survives a provider restart', () async {
    final first = BabyProvider();
    await first.load();
    first.toggleIntroduced('korenje');
    first.setReaction('korenje', 'ok');
    await Future<void>.delayed(const Duration(milliseconds: 50));

    final second = BabyProvider();
    await second.load();
    final korenje =
        second.foodGuide.firstWhere((f) => f.foodId == 'korenje');
    expect(korenje.introduced, isTrue);
    expect(korenje.reaction, 'ok');
  });
}
