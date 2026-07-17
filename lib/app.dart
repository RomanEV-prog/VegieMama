import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'providers/baby_provider.dart';
import 'providers/user_provider.dart';
import 'providers/tracking_provider.dart';
import 'providers/achievements_provider.dart';
import 'providers/recipes_provider.dart';
import 'providers/ai_chat_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/locale_provider.dart';
import 'providers/user_progress_provider.dart';
import 'routes/app_router.dart';
import 'theme/app_theme.dart';

class VeggieMamaApp extends StatefulWidget {
  const VeggieMamaApp({super.key});

  @override
  State<VeggieMamaApp> createState() => _VeggieMamaAppState();
}

class _VeggieMamaAppState extends State<VeggieMamaApp> {
  // The router's redirect watches this provider, so both share one
  // instance created here rather than inside MultiProvider.
  late final UserProvider _userProvider = UserProvider()..loadUser();
  late final GoRouter _router = createAppRouter(_userProvider);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _userProvider),
        ChangeNotifierProvider(create: (_) => TrackingProvider()..loadTodayData()),
        ChangeNotifierProvider(create: (_) => AchievementsProvider()..loadAchievements()),
        ChangeNotifierProvider(create: (_) => RecipesProvider()..loadRecipes()),
        ChangeNotifierProvider(create: (_) => AIChatProvider()..loadAssistants()),
        ChangeNotifierProvider(create: (_) => BabyProvider()..load()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProxyProvider2<TrackingProvider, UserProvider,
            UserProgressProvider>(
          create: (context) => UserProgressProvider(
            trackingProvider: context.read<TrackingProvider>(),
            userProvider: context.read<UserProvider>(),
          ),
          update: (_, tracking, user, previous) =>
              previous ??
              UserProgressProvider(
                trackingProvider: tracking,
                userProvider: user,
              ),
        ),
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (context, themeProvider, localeProvider, _) {
          return MaterialApp.router(
            title: 'VeggieMama',
            debugShowCheckedModeBanner: false,
            routerConfig: _router,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeProvider.themeMode,
            locale: localeProvider.locale,
            supportedLocales: LocaleProvider.supportedLocales,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}
