# Flutter gen-l10n v obstoječi aplikaciji (obseg, testi, batch sweep)

Iz seje VegieMama 17. 7. 2026: naknadna lokalizacija aplikacije s
hardcodanimi stringi (sl → sl/en/de) prek vgrajenega gen-l10n.

## Zakaj / arhitektura

- **Ključna odločitev obsega: UI ogrodje ≠ vsebina.** Prek l10n gre
  UI ogrodje (navigacija, gumbi, naslovi, nastavitve, onboarding,
  loading/empty/error stanja, disclaimerji). Uredniška vsebina
  (recepti, katalogi, empatična sporočila) NI za .arb — zanjo kasneje
  ločen vsebinski sistem (JSON per locale). Ta rez prepolovi delo in
  je arhitekturno pravilen; odstopanje ZAPIŠI v fazni dokument.
- Setup: `l10n.yaml` (template-arb-file: app_sl.arb), `generate: true`
  v pubspec, `flutter gen-l10n` po vsaki spremembi .arb.
- Dostop prek extensiona: `extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!; }` →
  `context.l10n.commonNext`.

## Konkretni recepti

- **Batch sweep s python skriptom** (seznam (file, old, new) trojk z
  natančnimi nizi + štetje uspehov/failov) je za 60+ zamenjav po 25
  datotekah bistveno zanesljivejši kot ročno urejanje. Pattern:
  vsak fail izpiši in ga obravnavaj posebej.
- Widgeti z defaultnim sporočilom: parameter spremeni v `String?` in
  razreši v build (`message ?? context.l10n.commonLoading`) — default
  vrednost konstruktorja ne more brati contexta.
- `const` odstrani samo tam, kjer vstopi `context.l10n` (widget sam,
  ne cela poddrevesa).
- Dialogi: uporabi `dialogContext.l10n`, ne zunanjega contexta.

## Gotchas

- **Widget testi se sesujejo z null check na AppLocalizations** — vsak
  testni `MaterialApp` potrebuje:
  `localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales, locale: Locale('sl')`.
- `AppLocalizations.localizationsDelegates` že vključuje
  GlobalMaterial/Widgets/Cupertino delegate — v app.dart zamenjaj ročni
  seznam, ne dodajaj obojega.
- `DateFormat('E', 'sl')` ipd. zahteva naložene locale podatke — v
  testih brez delegatov vrže exception; za fiksne labele raje ročna
  tabela (`['po','to','sr',...]`).
- .arb je JSON brez komentarjev; večvrstična besedila z `\n`. Po
  dodajanju ključev poženi `flutter gen-l10n`, sicer analyze ne vidi
  novih getterjev.
- Switch/case prek ThemeMode ipd. z l10n vrednostmi: metoda dobi
  `BuildContext` parameter (`_themeLabel(context, mode)`).
