# Faza 6 – Onboarding + persistence

**Status: ✅ končana (16. 7. 2026)**

## Cilj

Aplikacija dobi spomin: onboarding flow ustvari uporabnico, vsi podatki preživijo restart.

## Obseg

### Onboarding (`screens/onboarding/widgets/`)

* [x] večstopenjski flow (PageView): pozdrav → tip uporabnice → osnovni podatki → cilji → jezik/tema
* [x] tipi uporabnice: nosečnica / po porodu / dojenček / malček (1–3)
* [x] vnos PDP ali datuma rojstva otroka, faza dojenja, prehranske preference
* [x] vsak korak ima možnost »preskoči« — nežen vstop brez prisile
* [x] router redirect: dokler onboarding ni zaključen, vse rute vodijo na `/onboarding`

### Persistence

* [x] `StorageService` (Hive): user, tracking podatki po dnevih, favorites, stanje dosežkov
* [x] `PreferencesService` (SharedPreferences): jezik, tema, onboarding completed flag
* [x] repozitoriji dobijo local sloj: read-through (najprej local, mock/remote kot vir novih podatkov)
* [x] `ThemeProvider` in `LocaleProvider` bereta/pišeta prek `PreferencesService`
* [x] `TrackingProvider` mutacije se shranjujejo v Hive; ob zagonu se naloži današnji dan

## Sprejemni kriteriji

* Prvi zagon odpre onboarding; po zaključku se odpre Home in onboarding se ne prikaže več.
* Ime, tip uporabnice, tema, jezik, tracking vnosi in favorites preživijo popoln restart aplikacije.
* Brisanje podatkov (v nastavitvah) ponastavi aplikacijo na prvi zagon.
* `flutter analyze` brez napak.

## Opombe ob zaključku

* Onboarding zajema: pozdrav → tip uporabnice (vključno z novim tipom **malček 1–3**, `UserType.toddlerMom`) → ime + PDP/datum rojstva → jezik/tema. **Faza dojenja, prehranske preference in cilji** so izpuščeni, ker `UserModel` teh polj še nima — dodajo se skupaj z modelom v Fazi 7/8.
* `MockUserService` in `MockTrackingService` sta odstranjena — user in tracking sta zdaj izključno lokalna (Hive).
* Recepti: katalog ostaja mock, `isFavorite` oznake pa se shranjujejo lokalno (`favorite_ids`).
