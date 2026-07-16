# Faza 7 – Otrok 0–3: profil, uvajanje hrane, prehrana malčka

**Status: ⬜ ni začeta**

Razširitev v2: aplikacija spremlja otroka od rojstva do 3. leta. Pride po Fazi 6, ker potrebuje delujočo persistence (profil otroka mora preživeti restart).

## Cilj

Uporabnica z dojenčkom ali malčkom dobi enakovredno podporo kot nosečnica: profil otroka, vodnik uvajanja hrane in prehransko podporo za malčka na rastlinski prehrani.

## Obseg

### Modeli in podatki

* [ ] razširitev `BabyProfileModel`: allergies, notes, izpeljana `stage` (newborn / introducing / toddler)
* [ ] nov `FoodIntroductionModel`: foodId, name, category, recommendedFromMonth, introduced, introducedAt, reaction, notes
* [ ] vsebinska baza živil za uvajanje (mock/lokalni JSON): kategorije, priporočena starost, opombe za rastlinsko prehrano
* [ ] razširitev `TrackingDataModel`: babyMeals, nutrientCoverage (B12, železo, cink, jod, omega-3, D, kalcij, beljakovine)

### Sloji

* [ ] `BabyProvider` + `BabyRepository` + mock/local service
* [ ] rute `/baby` in `/baby/food-guide` (izven shell-a, z back gumbom)
* [ ] vstopne točke: kartica na Home + sekcija na Profilu (brez šestega zavihka)

### Zasloni (`screens/baby/`)

* [ ] `BabyProfileScreen` — ime, starost (meseci/leta), faza, alergije, opombe
* [ ] `FoodGuideScreen` — vodnik uvajanja hrane po starosti; seznam živil z označevanjem »uvedeno« in beleženjem reakcije
* [ ] prikaz pokritosti ključnih nutrientov za malčka — nežno, informativno, nikoli alarmantno

### Prilagoditev obstoječih zaslonov

* [ ] Home: poudarki glede na fazo otroka (uvajanje hrane pri ~6 mesecih, jedilniki za malčka)
* [ ] Tracking: kartice za obroke otroka, ko je `userType` infant/toddler
* [ ] Recepti: privzeti filter po starosti otroka

## Vsebinska pravila

* vsaka prehranska vsebina za otroka ima disclaimer (ne nadomešča pediatra)
* smernice sledijo WHO/nacionalnim priporočilom; brez strašenja
* izbirčnost je normalna faza, ne problem
* rast/percentili (v1.1+) so informacija, ne ocena

## Sprejemni kriteriji

* Profil otroka se ustvari (v onboardingu ali naknadno) in preživi restart.
* Vodnik uvajanja prikazuje živila po starosti; označevanje »uvedeno« se shrani.
* Home in Tracking se vidno prilagodita fazi otroka.
* Vsi otroški zasloni imajo disclaimer.
* `flutter analyze` brez napak.
