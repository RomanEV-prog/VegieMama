import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_sl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('sl')
  ];

  /// No description provided for @appTitle.
  ///
  /// In sl, this message translates to:
  /// **'VeggieMama'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In sl, this message translates to:
  /// **'Domov'**
  String get navHome;

  /// No description provided for @navTracking.
  ///
  /// In sl, this message translates to:
  /// **'Sledenje'**
  String get navTracking;

  /// No description provided for @navRecipes.
  ///
  /// In sl, this message translates to:
  /// **'Recepti'**
  String get navRecipes;

  /// No description provided for @navAI.
  ///
  /// In sl, this message translates to:
  /// **'AI'**
  String get navAI;

  /// No description provided for @navProfile.
  ///
  /// In sl, this message translates to:
  /// **'Profil'**
  String get navProfile;

  /// No description provided for @loading.
  ///
  /// In sl, this message translates to:
  /// **'Nalaganje...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In sl, this message translates to:
  /// **'Prišlo je do težave'**
  String get error;

  /// No description provided for @retry.
  ///
  /// In sl, this message translates to:
  /// **'Poskusi znova'**
  String get retry;

  /// No description provided for @profile.
  ///
  /// In sl, this message translates to:
  /// **'Profil'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In sl, this message translates to:
  /// **'Nastavitve'**
  String get settings;

  /// No description provided for @premiumStatus.
  ///
  /// In sl, this message translates to:
  /// **'Premium status'**
  String get premiumStatus;

  /// No description provided for @achievements.
  ///
  /// In sl, this message translates to:
  /// **'Dosežki'**
  String get achievements;

  /// No description provided for @favoriteRecipes.
  ///
  /// In sl, this message translates to:
  /// **'Najljubši recepti'**
  String get favoriteRecipes;

  /// No description provided for @aiAssistants.
  ///
  /// In sl, this message translates to:
  /// **'AI asistenti'**
  String get aiAssistants;

  /// No description provided for @trackingSummary.
  ///
  /// In sl, this message translates to:
  /// **'Povzetek sledenja'**
  String get trackingSummary;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'sl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'sl':
      return AppLocalizationsSl();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
