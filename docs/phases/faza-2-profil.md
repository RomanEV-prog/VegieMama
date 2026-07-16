# Faza 2 – Profile vertical slice

**Status: ⬜ ni začeta**

## Cilj

Prvi pravi zaslon aplikacije: profil uporabnice, ki bere podatke iz providerjev in pokaže celoten UX ton aplikacije (nežno, pregledno, brez pritiska).

## Obseg

### Zasloni in widgeti

* [ ] `ProfileScreen` — sestavljen iz sekcij, brez lastne poslovne logike
* [ ] preselitev profilnih widgetov iz `lib/widgets/` v `lib/screens/profile/widgets/`:
  * [ ] `profile_header.dart` — ime, avatar, faza (teden nosečnosti / starost otroka)
  * [ ] `tracking_summary.dart` — povzetek dneva iz `TrackingProvider` + quick add (voda)
  * [ ] `achievements_section.dart` — dosežki iz `AchievementsProvider` (horizontalni seznam badge-ev)
  * [ ] `ai_assistants_section.dart` — vstop v AI klepet
  * [ ] `favorite_recipes_section.dart` — najljubši recepti iz `RecipesProvider`
  * [ ] `premium_status_card.dart` — nežen prikaz premium statusa
  * [ ] `settings_preview_section.dart` — vstop v nastavitve
* [ ] globalni `lib/widgets/` obdrži samo: motivational_banner, achievement_badge, section_title, primary_action_button, info_card

### Tehnično

* [ ] izračun tedna nosečnosti / starosti otroka v `date_helper.dart` (ne v widgetih)
* [ ] `UserProgressProvider` napolni blage indikatorje napredka
* [ ] poenotenje `theme/theme.dart` in `theme/app_theme.dart` v eno datoteko
* [ ] loading/empty/error stanja prek obstoječih core widgetov

## Pravila

* podatki izključno prek `Consumer`/`context.watch`, mutacije prek `context.read<...>()`
* `TrackingSummary` je lahko `StatefulWidget` zaradi animacij, domenski podatki pa pridejo iz providerja
* nobenih »nisi dosegla« formulacij — napredek je vedno prikazan nežno

## Sprejemni kriteriji

* Profil prikazuje mock podatke uporabnice, dneva, dosežkov in receptov brez napak.
* Quick add za vodo spremeni stanje v `TrackingProvider` in UI se osveži.
* Ob prazni/napačni situaciji se pokaže nežen empty/error state.
* `flutter analyze` brez napak.
