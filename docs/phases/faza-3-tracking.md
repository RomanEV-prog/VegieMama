# Faza 3 – Tracking vertical slice

**Status: ⬜ ni začeta**

## Cilj

Polni zaslon dnevnega sledenja: tekočine, obroki, počutje, spanje, vitamini, dojenje/hranjenje — z quick add interakcijami in nežnim dnevnim/tedenskim pregledom.

## Obseg

### Zasloni in widgeti (`screens/tracking/widgets/`)

* [ ] `TrackingScreen` — dnevni pregled kot privzeti pogled
* [ ] `water_tracker_card.dart` — napredek + quick add (npr. +250 ml), animacija ob dodajanju
* [ ] `meals_card.dart` — beleženje obrokov
* [ ] `mood_selector.dart` — izbira počutja (1–5, nežne ikone, brez ocenjevanja)
* [ ] `sleep_card.dart` — ure spanja
* [ ] `vitamins_card.dart` — vitamini/dodatki (B12, železo, D …) kot čipi za odkljukanje
* [ ] `breastfeeding_card.dart` — prikaže se samo za fazo po porodu / dojenček
* [ ] `weekly_overview.dart` — tedenski pregled iz `getWeekData()`, nežni trendi brez rdečih opozoril

### Tehnično

* [ ] `TrackingProvider`: vse mutacije po spremembi pokličejo `_repository.saveTrackingData(...)` (mock zaenkrat samo simulira shranjevanje)
* [ ] prikaz kartic pogojen s `userType` (dojenje samo, ko je relevantno)
* [ ] `emotional_feedback.dart` generira nežne povratne stavke ob vnosih

## Sprejemni kriteriji

* Vsi vnosi delujejo prek providerja in se odražajo v UI.
* Tedenski pregled prikazuje mock podatke za 7 dni.
* Kartice se prilagajajo tipu uporabnice.
* Nobena formulacija ne deluje kot kritika ali opozorilo.
* `flutter analyze` brez napak.
