# Faza 4 – Recipes vertical slice

**Status: ✅ končana (16. 7. 2026)**

## Cilj

Uporaben seznam rastlinskih receptov s filtri, favorites in detajlnim pogledom.

## Obseg

### Zasloni in widgeti (`screens/recipes/widgets/`)

* [x] `RecipesScreen` — seznam receptov s karticami
* [x] `recipe_card.dart` — slika/placeholder, naslov, oznake, srček za favorite
* [x] `recipe_filters.dart` — filtri kot čipi: nosečnost, dojenje, uvajanje hrane, malček 1–3, železo, B12, hitri obroki
* [x] `favorites_row.dart` — najljubši na vrhu
* [x] `RecipeDetailScreen` — sestavine, postopek, prehranski poudarki, oznaka primernosti (za koga / od katere starosti)

### Tehnično

* [x] `RecipesProvider`: filter stanje, toggle favorite, recent
* [x] `MockRecipeService` razširiti na vsaj 12–15 realnih rastlinskih receptov s pravimi oznakami (vključno z recepti za uvajanje hrane in malčke — priprava na Fazo 7)
* [x] `RecipeModel.suitableFor` podpira starostne razpone otroka

## Sprejemni kriteriji

* Filtriranje in favorites delujeta in preživita navigacijo med zavihki.
* Detail prikaže vse podatke recepta, favorite se sinhronizira s seznamom.
* Recepti za otroke imajo vidno starostno oznako in disclaimer.
* `flutter analyze` brez napak.
