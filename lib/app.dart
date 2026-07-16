import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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

class VeggieMamaApp extends StatelessWidget {
  const VeggieMamaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()..loadUser()),
        ChangeNotifierProvider(create: (_) => TrackingProvider()..loadTodayData()),
        ChangeNotifierProvider(create: (_) => AchievementsProvider()..loadAchievements()),
        ChangeNotifierProvider(create: (_) => RecipesProvider()..loadRecipes()),
        ChangeNotifierProvider(create: (_) => AIChatProvider()..loadAssistants()),
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
            routerConfig: appRouter,
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