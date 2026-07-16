# Flutter widget testi s Provider + mock zamiki + Hive (pasti in recepti)

Iz seje VegieMama 16. 7. 2026. Uporabi pri pisanju/razhroščevanju widget
testov v projektih s Provider state managementom, mock servisi z
`Future.delayed` in lokalno persistenco (Hive + SharedPreferences).

## Zakaj / arhitektura

- Provider `create:` je **len** — provider (in njegov `loadX()`) se ustvari
  šele, ko ga prvi widget dejansko prebere. Zato en `pump(zamik)` ni dovolj:
  prva runda naloži user-ja, šele nato se zgradi odvisni widget, ki sproži
  naslednji provider z novim zamikom.
- Testno okolje za persistenco: `test/helpers/test_env.dart` →
  `initTestEnv(user:, today:)` inicializira Hive v temp mapo
  (`StorageService.init(testPath: ...)`) in
  `SharedPreferences.setMockInitialValues({})`, nato seeda podatke.

## Konkretni recepti

```dart
// standardni "počakaj na mock zamike + lene providerje"
await tester.pumpWidget(app);
await tester.pump(const Duration(milliseconds: 600));
await tester.pump();                                  // frame po notifyListeners
await tester.pump(const Duration(milliseconds: 600)); // 2. runda za lene providerje
await tester.pump();

// elementi pod pregibom (ListView gradi leno, viewport 800x600)
await tester.scrollUntilVisible(find.text('X'), 200,
    scrollable: find.byType(Scrollable).first);

// horizontalni seznam znotraj vertikalnega: ancestor vrne VEČ scrollablov
scrollable: find.ancestor(of: find.text('čip-v-vrstici'),
    matching: find.byType(Scrollable)).first,
// + po scrollUntilVisible pred tapom še pumpAndSettle(), sicer tap pade
// med ballistic scroll in se pogoltne
```

## Gotchas

- **NAJPOMEMBNEJŠE: pravi Hive v widget testih visi.** `testWidgets` telo
  teče v FakeAsync zoni, kjer se pravi I/O (Hive open/put/clear/close)
  nikoli ne dokonča → test visi do 10-min timeouta, `pumpAndSettle` v
  neskončnost, naslednji testi v isti datoteki podedujejo »zastrupljene«
  škatle (tudi `Hive.close` v setUp naslednjega testa obvisi). `tester.runAsync`
  pomaga samo za posamične klice in NE reši zapisov, ki jih sproži sama
  aplikacija (npr. `saveUser` ob koncu onboardinga). Prava rešitev:
  storage servis dobi **in-memory testni način**
  (`StorageService.init(inMemory: true)` → navadni `Map`) in testi nikoli
  ne tipajo pravega Hive; pravi I/O testiraš kvečjemu v čistem `test()`
  brez FakeAsync. Bonus: celotna suita z 20 s pade na 5 s.
  Simptom za prepoznavo: reporter vsako sekundo izpisuje isto ime testa.

- **`pumpAndSettle()` visi 10 minut**, če je kjer koli na zaslonu
  indeterminate `CircularProgressIndicator` (spinner v loading gumbu,
  LoadingState ...). V testih polnih zaslonov raje omejeni
  `pump(Duration(...))` klici.
- **Dva sočasna `flutter` ukaza se mrtvo zakleneta** na startup lock —
  drugi tiho čaka brez izpisa. Simptom: test run »visi« brez outputa.
  Rešitev: `Get-Process dart | Stop-Process -Force` za obtičale procese,
  nato en sam ukaz naenkrat. NIKOLI ne poganjaj `flutter test` in
  `flutter run/build` vzporedno.
- **`... | tail -3` skrije ves output do konca procesa** — pri dolgih
  test runih poganjaj brez pipe (v datoteko) in beri vmesno stanje.
- **`AnimatedSwitcher` med prehodom prikaže stari IN novi widget** —
  `find.text(...)` najde 2 kandidata, če imata enako besedilo. V testu
  izberi vrednost z DRUGAČNIM besedilom ali počakaj konec prehoda.
- **`const` mock seznami so nespremenljivi** — provider, ki dela
  `_list[i] = ...` na seznamu, dobljenem iz repozitorija, se sesuje z
  `Cannot modify an unmodifiable list`. Provider naj vedno kopira:
  `_list = List.of(await repo.get())`. (Test je ujel pravi produkcijski bug.)
- **Verižni mock zamiki se seštevajo**: repo metode, ki druga drugo kličejo
  (getFavorites → getAllRecipes), podvojijo `Future.delayed` in test s
  600 ms pumpa ostane na LoadingState. Provider naj pridobi podatke enkrat
  in izpelje ostalo lokalno.
- Widget z `DateFormat('E','sl')` v testu brez lokalizacijskih delegatov
  vrže exception — za fiksne slovenske labele raje ročna tabela
  (`['po','to','sr',...]`).
