# Faza 2 – Profile vertical slice

**Status: ✅ končana (16. 7. 2026)**

> Opomba ob zaključku: vse točke izvedene; `UserProgressProvider` obstaja in je registriran,
> njegove izpeljane indikatorje pa bo prvi zares uporabil Home/Tracking (Faza 3), ker
> `TrackingSummary` po načrtu bere neposredno iz `TrackingProvider`. Sprejemni kriteriji
> potrjeni s widget testi v `test/profile_screen_test.dart`.

## Cilj

Prvi pravi zaslon aplikacije: profil uporabnice, ki bere podatke iz providerjev in pokaže celoten UX ton aplikacije (nežno, pregledno, brez pritiska).

## Obseg

### Zasloni in widgeti

* [x] `ProfileScreen` — sestavljen iz sekcij, brez lastne poslovne logike
* [x] preselitev profilnih widgetov iz `lib/widgets/` v `lib/screens/profile/widgets/`:
  * [x] `profile_header.dart` — ime, avatar, faza (teden nosečnosti / starost otroka)
  * [x] `tracking_summary.dart` — povzetek dneva iz `TrackingProvider` + quick add (voda)
  * [x] `achievements_section.dart` — dosežki iz `AchievementsProvider` (horizontalni seznam badge-ev)
  * [x] `ai_assistants_section.dart` — vstop v AI klepet
  * [x] `favorite_recipes_section.dart` — najljubši recepti iz `RecipesProvider`
  * [x] `premium_status_card.dart` — nežen prikaz premium statusa
  * [x] `settings_preview_section.dart` — vstop v nastavitve
* [x] globalni `lib/widgets/` obdrži samo: motivational_banner, achievement_badge, section_title, primary_action_button, info_card

### Tehnično

* [x] izračun tedna nosečnosti / starosti otroka v `date_helper.dart` (ne v widgetih)
* [x] `UserProgressProvider` napolni blage indikatorje napredka
* [x] poenotenje `theme/theme.dart` in `theme/app_theme.dart` v eno datoteko
* [x] loading/empty/error stanja prek obstoječih core widgetov

## Pravila

* podatki izključno prek `Consumer`/`context.watch`, mutacije prek `context.read<...>()`
* `TrackingSummary` je lahko `StatefulWidget` zaradi animacij, domenski podatki pa pridejo iz providerja
* nobenih »nisi dosegla« formulacij — napredek je vedno prikazan nežno

## Sprejemni kriteriji

* Profil prikazuje mock podatke uporabnice, dneva, dosežkov in receptov brez napak.
* Quick add za vodo spremeni stanje v `TrackingProvider` in UI se osveži.
* Ob prazni/napačni situaciji se pokaže nežen empty/error state.
* `flutter analyze` brez napak.
