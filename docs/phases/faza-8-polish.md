# Faza 8 – Polish in priprava na izdajo

**Status: ✅ končana (17. 7. 2026) — z opombami spodaj**

## Cilj

Prototip postane izdelek: prevodi, testi, dosežki, vizualni polish in tehnično čiščenje pred prvo izdajo.

## Obseg

### Lokalizacija

* [x] UI ogrodje prek l10n, vključno z labeli bottom navigacije (vsebinski sloj → v1.1, glej opombe)
* [x] popolni prevodi sl / en / de v `.arb` datotekah
* [x] pregled tona vseh treh jezikov — nežnost mora preživeti prevod

### Dosežki in mikrointerakcije

* [x] `AchievementsProvider` unlock logika vezana na dejanske vnose
* [ ] Lottie animacije — odloženo v v1.1 (mikrointerakcije pokrite s Flutter animacijami)
* [x] `motivational_banner.dart` z rotirajočimi nežnimi sporočili glede na fazo

### Testi in kakovost

* [x] unit testi za helperje (date_helper — izračun tedna/starosti, validation)
* [x] unit testi za providerje (tracking mutacije, filter logika)
* [x] widget testi za ključne flowe (onboarding, quick add, favorite)
* [x] `flutter analyze` čist, lint pravila poenotena

### Tehnično čiščenje

* [x] odstraniti neuporabljene datoteke in podvojene theme datoteke
* [x] app ikona in splash (generirana); ilustracije in Lottie datoteke → v1.1
* [x] app ikona in splash screen
* [x] Nastavitve: jezik, tema, brisanje podatkov, o aplikaciji, pravno obvestilo/disclaimer

## Sprejemni kriteriji

* Aplikacija je v celoti uporabna v vseh treh jezikih.
* Testi tečejo in so zeleni; `flutter analyze` brez opozoril.
* Ni placeholderjev in »skoraj tu« besedil.
* Pripravljen release build (Android kot prva tarča) — Play Store checklist v [design-guidelines.md §8](../design-guidelines.md).

## Opombe ob zaključku

* **l10n obseg:** celotno UI ogrodje (navigacija, onboarding, nastavitve, gumbi, naslovi zaslonov, stanja) je prevedeno v sl/en/de prek gen-l10n. **Vsebinski sloj** (recepti, katalog živil, empatična sporočila, naslovi kartic sledenja) namenoma ostaja v slovenščini — prevede se v v1.1 z ločenim vsebinskim sistemom (JSON per locale), ker gre za uredniško vsebino, ne UI stringe.
* **Lottie animacije** odložene v v1.1 — mikrointerakcije so pokrite s Flutter animacijami (AnimatedScale/Container/Switcher, TweenAnimationBuilder) po design-guidelines.
* **Dosežki** so zdaj vezani na prave vnose prek `AchievementsService` (Hive števci: voda, počutje, aktivni dnevi, favoriti, uvedena živila). »Nežna zvestoba« šteje aktivne dneve in NI streak — prekinjen dan ničesar ne ponastavi (hooked-ux etika).
* **App ikona in splash** sta generirana programsko (PIL) v brand barvah; brez novih paketov.
* **Play release:** APK se gradi; za objavo na Play je treba še ustvariti keystore (ročni korak uporabnika) in AAB — glej design-guidelines §8.
