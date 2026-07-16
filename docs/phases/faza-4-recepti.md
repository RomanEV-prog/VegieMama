# Faza 4 – Recipes vertical slice

**Status: ⬜ ni začeta**

## Cilj

Uporaben seznam rastlinskih receptov s filtri, favorites in detajlnim pogledom.

## Obseg

### Zasloni in widgeti (`screens/recipes/widgets/`)

* [ ] `RecipesScreen` — seznam receptov s karticami
* [ ] `recipe_card.dart` — slika/placeholder, naslov, oznake, srček za favorite
* [ ] `recipe_filters.dart` — filtri kot čipi: nosečnost, dojenje, uvajanje hrane, malček 1–3, železo, B12, hitri obroki
* [ ] `favorites_row.dart` — najljubši na vrhu
* [ ] `RecipeDetailScreen` — sestavine, postopek, prehranski poudarki, oznaka primernosti (za koga / od katere starosti)

### Tehnično

* [ ] `RecipesProvider`: filter stanje, toggle favorite, recent
* [ ] `MockRecipeService` razširiti na vsaj 12–15 realnih rastlinskih receptov s pravimi oznakami (vključno z recepti za uvajanje hrane in malčke — priprava na Fazo 7)
* [ ] `RecipeModel.suitableFor` podpira starostne razpone otroka

## Sprejemni kriteriji

* Filtriranje in favorites delujeta in preživita navigacijo med zavihki.
* Detail prikaže vse podatke recepta, favorite se sinhronizira s seznamom.
* Recepti za otroke imajo vidno starostno oznako in disclaimer.
* `flutter analyze` brez napak.
