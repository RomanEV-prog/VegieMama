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

  /// No description provided for @commonNext.
  ///
  /// In sl, this message translates to:
  /// **'Naprej'**
  String get commonNext;

  /// No description provided for @commonSkip.
  ///
  /// In sl, this message translates to:
  /// **'Preskoči'**
  String get commonSkip;

  /// No description provided for @commonFinish.
  ///
  /// In sl, this message translates to:
  /// **'Konči'**
  String get commonFinish;

  /// No description provided for @commonStart.
  ///
  /// In sl, this message translates to:
  /// **'Začniva 🌿'**
  String get commonStart;

  /// No description provided for @commonCancel.
  ///
  /// In sl, this message translates to:
  /// **'Prekliči'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In sl, this message translates to:
  /// **'Shrani'**
  String get commonSave;

  /// No description provided for @commonDelete.
  ///
  /// In sl, this message translates to:
  /// **'Izbriši'**
  String get commonDelete;

  /// No description provided for @commonRetry.
  ///
  /// In sl, this message translates to:
  /// **'Poskusi znova'**
  String get commonRetry;

  /// No description provided for @commonLoading.
  ///
  /// In sl, this message translates to:
  /// **'Samo trenutek... 🌿'**
  String get commonLoading;

  /// No description provided for @commonEmpty.
  ///
  /// In sl, this message translates to:
  /// **'Tukaj še ni ničesar – in to je povsem ok 💚'**
  String get commonEmpty;

  /// No description provided for @titleSettings.
  ///
  /// In sl, this message translates to:
  /// **'Nastavitve'**
  String get titleSettings;

  /// No description provided for @titleRecipe.
  ///
  /// In sl, this message translates to:
  /// **'Recept'**
  String get titleRecipe;

  /// No description provided for @titleAI.
  ///
  /// In sl, this message translates to:
  /// **'AI Pomočnik'**
  String get titleAI;

  /// No description provided for @titleBaby.
  ///
  /// In sl, this message translates to:
  /// **'Tvoj otrok'**
  String get titleBaby;

  /// No description provided for @titleFoodGuide.
  ///
  /// In sl, this message translates to:
  /// **'Uvajanje hrane'**
  String get titleFoodGuide;

  /// No description provided for @onbWelcomeTitle.
  ///
  /// In sl, this message translates to:
  /// **'Dobrodošla v VeggieMama'**
  String get onbWelcomeTitle;

  /// No description provided for @onbWelcomeBody.
  ///
  /// In sl, this message translates to:
  /// **'Tvoja nežna spremljevalka na rastlinski poti — od nosečnosti do malčkovih prvih let.\n\nBrez pritiska, brez ocenjevanja. Samo podpora.'**
  String get onbWelcomeBody;

  /// No description provided for @onbTypeTitle.
  ///
  /// In sl, this message translates to:
  /// **'Kje na poti si?'**
  String get onbTypeTitle;

  /// No description provided for @onbTypeSubtitle.
  ///
  /// In sl, this message translates to:
  /// **'Aplikacijo prilagodim tvojemu obdobju. Kadar koli lahko to spremeniš.'**
  String get onbTypeSubtitle;

  /// No description provided for @onbTypePregnant.
  ///
  /// In sl, this message translates to:
  /// **'Nosečnica'**
  String get onbTypePregnant;

  /// No description provided for @onbTypePregnantSub.
  ///
  /// In sl, this message translates to:
  /// **'Pričakujem otroka'**
  String get onbTypePregnantSub;

  /// No description provided for @onbTypePostpartum.
  ///
  /// In sl, this message translates to:
  /// **'Po porodu'**
  String get onbTypePostpartum;

  /// No description provided for @onbTypePostpartumSub.
  ///
  /// In sl, this message translates to:
  /// **'Okrevam in se privajam'**
  String get onbTypePostpartumSub;

  /// No description provided for @onbTypeBaby.
  ///
  /// In sl, this message translates to:
  /// **'Mamica z dojenčkom'**
  String get onbTypeBaby;

  /// No description provided for @onbTypeBabySub.
  ///
  /// In sl, this message translates to:
  /// **'Otrok do 1. leta'**
  String get onbTypeBabySub;

  /// No description provided for @onbTypeToddler.
  ///
  /// In sl, this message translates to:
  /// **'Mamica z malčkom'**
  String get onbTypeToddler;

  /// No description provided for @onbTypeToddlerSub.
  ///
  /// In sl, this message translates to:
  /// **'Otrok od 1 do 3 let'**
  String get onbTypeToddlerSub;

  /// No description provided for @onbBasicsTitle.
  ///
  /// In sl, this message translates to:
  /// **'Malo o tebi'**
  String get onbBasicsTitle;

  /// No description provided for @onbBasicsSubtitle.
  ///
  /// In sl, this message translates to:
  /// **'Vse je neobvezno — deli samo, kar želiš.'**
  String get onbBasicsSubtitle;

  /// No description provided for @onbNameLabel.
  ///
  /// In sl, this message translates to:
  /// **'Tvoje ime'**
  String get onbNameLabel;

  /// No description provided for @onbNameHint.
  ///
  /// In sl, this message translates to:
  /// **'Kako naj te kličem?'**
  String get onbNameHint;

  /// No description provided for @onbDueDate.
  ///
  /// In sl, this message translates to:
  /// **'Predviden datum poroda (PDP)'**
  String get onbDueDate;

  /// No description provided for @onbBirthDate.
  ///
  /// In sl, this message translates to:
  /// **'Datum rojstva otroka'**
  String get onbBirthDate;

  /// No description provided for @onbPickDate.
  ///
  /// In sl, this message translates to:
  /// **'Izberi datum'**
  String get onbPickDate;

  /// No description provided for @onbDateHelpPregnant.
  ///
  /// In sl, this message translates to:
  /// **'Z njim izračunam teden nosečnosti in prilagodim vsebine.'**
  String get onbDateHelpPregnant;

  /// No description provided for @onbDateHelpChild.
  ///
  /// In sl, this message translates to:
  /// **'Z njim izračunam starost otroka in prilagodim vsebine.'**
  String get onbDateHelpChild;

  /// No description provided for @onbSettingsTitle.
  ///
  /// In sl, this message translates to:
  /// **'Še zadnji dotik'**
  String get onbSettingsTitle;

  /// No description provided for @onbSettingsSubtitle.
  ///
  /// In sl, this message translates to:
  /// **'Izberi jezik in videz. Oboje lahko kadar koli spremeniš v nastavitvah.'**
  String get onbSettingsSubtitle;

  /// No description provided for @language.
  ///
  /// In sl, this message translates to:
  /// **'Jezik'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In sl, this message translates to:
  /// **'Tema'**
  String get theme;

  /// No description provided for @themeLight.
  ///
  /// In sl, this message translates to:
  /// **'Svetla'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In sl, this message translates to:
  /// **'Temna'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In sl, this message translates to:
  /// **'Sistemska'**
  String get themeSystem;

  /// No description provided for @setAppearance.
  ///
  /// In sl, this message translates to:
  /// **'Videz'**
  String get setAppearance;

  /// No description provided for @setPrivacy.
  ///
  /// In sl, this message translates to:
  /// **'Zasebnost'**
  String get setPrivacy;

  /// No description provided for @setAbout.
  ///
  /// In sl, this message translates to:
  /// **'O aplikaciji'**
  String get setAbout;

  /// No description provided for @setDeleteData.
  ///
  /// In sl, this message translates to:
  /// **'Izbriši moje podatke'**
  String get setDeleteData;

  /// No description provided for @setDeleteSubtitle.
  ///
  /// In sl, this message translates to:
  /// **'Profil, vnosi in najljubši recepti se izbrišejo s te naprave.'**
  String get setDeleteSubtitle;

  /// No description provided for @setDeleteConfirmTitle.
  ///
  /// In sl, this message translates to:
  /// **'Izbrišem tvoje podatke?'**
  String get setDeleteConfirmTitle;

  /// No description provided for @setDeleteConfirmBody.
  ///
  /// In sl, this message translates to:
  /// **'Izbrisalo bo profil, dnevne vnose in najljubše recepte. Tega ni mogoče razveljaviti.'**
  String get setDeleteConfirmBody;

  /// No description provided for @setAboutText.
  ///
  /// In sl, this message translates to:
  /// **'VeggieMama 1.0\n\nAplikacija je v podporo in ne nadomešča nasveta zdravnika, pediatra ali druge strokovne osebe. Vsi tvoji podatki ostanejo na tej napravi.'**
  String get setAboutText;

  /// No description provided for @aiDisclaimer.
  ///
  /// In sl, this message translates to:
  /// **'Lina, Maja in Zala so v podporo in ne nadomeščajo zdravnika ali pediatra.'**
  String get aiDisclaimer;

  /// No description provided for @aiInputHint.
  ///
  /// In sl, this message translates to:
  /// **'Napiši sporočilo...'**
  String get aiInputHint;
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
