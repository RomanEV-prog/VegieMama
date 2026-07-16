# Faza 8 – Polish in priprava na izdajo

**Status: ⬜ ni začeta**

## Cilj

Prototip postane izdelek: prevodi, testi, dosežki, vizualni polish in tehnično čiščenje pred prvo izdajo.

## Obseg

### Lokalizacija

* [ ] vsi hardcodani stringi (vključno z labeli bottom navigacije v `app_router.dart`) prek l10n
* [ ] popolni prevodi sl / en / de v `.arb` datotekah
* [ ] pregled tona vseh treh jezikov — nežnost mora preživeti prevod

### Dosežki in mikrointerakcije

* [ ] `AchievementsProvider` unlock logika vezana na dejanske vnose
* [ ] Lottie animacije za odklepanje dosežkov in quick add
* [ ] `motivational_banner.dart` z rotirajočimi nežnimi sporočili glede na fazo

### Testi in kakovost

* [ ] unit testi za helperje (date_helper — izračun tedna/starosti, validation)
* [ ] unit testi za providerje (tracking mutacije, filter logika)
* [ ] widget testi za ključne flowe (onboarding, quick add, favorite)
* [ ] `flutter analyze` čist, lint pravila poenotena

### Tehnično čiščenje

* [ ] odstraniti neuporabljene datoteke in podvojene theme datoteke
* [ ] assets: ikone, ilustracije, Lottie datoteke; posodobiti pubspec
* [ ] app ikona in splash screen
* [ ] Nastavitve: jezik, tema, brisanje podatkov, o aplikaciji, pravno obvestilo/disclaimer

## Sprejemni kriteriji

* Aplikacija je v celoti uporabna v vseh treh jezikih.
* Testi tečejo in so zeleni; `flutter analyze` brez opozoril.
* Ni placeholderjev in »skoraj tu« besedil.
* Pripravljen release build (Android kot prva tarča) — Play Store checklist v [design-guidelines.md §8](../design-guidelines.md).
