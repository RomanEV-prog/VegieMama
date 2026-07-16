# Faza 3 – Tracking vertical slice

**Status: ✅ končana (16. 7. 2026)**

## Cilj

Polni zaslon dnevnega sledenja: tekočine, obroki, počutje, spanje, vitamini, dojenje/hranjenje — z quick add interakcijami in nežnim dnevnim/tedenskim pregledom.

## Obseg

### Zasloni in widgeti (`screens/tracking/widgets/`)

* [x] `TrackingScreen` — dnevni pregled kot privzeti pogled
* [x] `water_tracker_card.dart` — napredek + quick add (npr. +250 ml), animacija ob dodajanju
* [x] `meals_card.dart` — beleženje obrokov
* [x] `mood_selector.dart` — izbira počutja (1–5, nežne ikone, brez ocenjevanja)
* [x] `sleep_card.dart` — ure spanja
* [x] `vitamins_card.dart` — vitamini/dodatki (B12, železo, D …) kot čipi za odkljukanje
* [x] `breastfeeding_card.dart` — prikaže se samo za fazo po porodu / dojenček
* [x] `weekly_overview.dart` — tedenski pregled iz `getWeekData()`, nežni trendi brez rdečih opozoril

### Tehnično

* [x] `TrackingProvider`: vse mutacije po spremembi pokličejo `_repository.saveTrackingData(...)` (mock zaenkrat samo simulira shranjevanje)
* [x] prikaz kartic pogojen s `userType` (dojenje samo, ko je relevantno)
* [x] `emotional_feedback.dart` generira nežne povratne stavke ob vnosih

## Sprejemni kriteriji

* Vsi vnosi delujejo prek providerja in se odražajo v UI.
* Tedenski pregled prikazuje mock podatke za 7 dni.
* Kartice se prilagajajo tipu uporabnice.
* Nobena formulacija ne deluje kot kritika ali opozorilo.
* `flutter analyze` brez napak.
