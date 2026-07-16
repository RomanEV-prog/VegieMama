# Faza 6 – Onboarding + persistence

**Status: ⬜ ni začeta**

## Cilj

Aplikacija dobi spomin: onboarding flow ustvari uporabnico, vsi podatki preživijo restart.

## Obseg

### Onboarding (`screens/onboarding/widgets/`)

* [ ] večstopenjski flow (PageView): pozdrav → tip uporabnice → osnovni podatki → cilji → jezik/tema
* [ ] tipi uporabnice: nosečnica / po porodu / dojenček / malček (1–3)
* [ ] vnos PDP ali datuma rojstva otroka, faza dojenja, prehranske preference
* [ ] vsak korak ima možnost »preskoči« — nežen vstop brez prisile
* [ ] router redirect: dokler onboarding ni zaključen, vse rute vodijo na `/onboarding`

### Persistence

* [ ] `StorageService` (Hive): user, tracking podatki po dnevih, favorites, stanje dosežkov
* [ ] `PreferencesService` (SharedPreferences): jezik, tema, onboarding completed flag
* [ ] repozitoriji dobijo local sloj: read-through (najprej local, mock/remote kot vir novih podatkov)
* [ ] `ThemeProvider` in `LocaleProvider` bereta/pišeta prek `PreferencesService`
* [ ] `TrackingProvider` mutacije se shranjujejo v Hive; ob zagonu se naloži današnji dan

## Sprejemni kriteriji

* Prvi zagon odpre onboarding; po zaključku se odpre Home in onboarding se ne prikaže več.
* Ime, tip uporabnice, tema, jezik, tracking vnosi in favorites preživijo popoln restart aplikacije.
* Brisanje podatkov (v nastavitvah) ponastavi aplikacijo na prvi zagon.
* `flutter analyze` brez napak.
