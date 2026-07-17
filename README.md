# VeggieMama 🌿

Nežna Flutter aplikacija za nosečnice in mamice na rastlinski prehrani —
od nosečnosti do otrokovega 3. leta. Sledenje dneva, recepti s
prehranskimi poudarki, profil otroka z vodnikom uvajanja hrane in AI
pomočnice (Gemini) z vgrajenimi varnostnimi pravili.

**Stanje: MVP v1.0 — vseh 8 razvojnih faz zaključenih** (julij 2026).

## Funkcionalnosti

- **Onboarding** po fazi uporabnice: nosečnica / po porodu / dojenček / malček (1–3)
- **Domov** s poudarki glede na fazo in pregledom dneva
- **Sledenje**: voda, obroki, počutje, spanje, vitamini, dojenje, obroki otroka
- **Recepti**: 14 rastlinskih receptov s filtri (nosečnost, dojenje, uvajanje hrane, malček, železo, B12)
- **Otrok 0–3**: profil, faze razvoja, vodnik uvajanja 18 živil z alergeni in reakcijami
- **AI pomočnice** Lina/Maja/Zala (Gemini): ločeni pogovori, zdravstvena vprašanja vedno preusmerijo k zdravniku
- **Dosežki** na pravih vnosih (brez streak kazni), lokalna persistenca (Hive), l10n sl/en/de

## Zagon

```bash
cp .env.example .env    # vpiši GEMINI_API_KEY (brez njega AI teče na mocku)
flutter pub get
flutter run
```

> `.env` mora obstajati (bundlan je kot asset), sicer build pade.

## Razvoj

```bash
flutter analyze   # mora biti čist
flutter test      # 26 widget/unit testov
```

Ključni dokumenti:

- [ARCHITECTURE.md](ARCHITECTURE.md) — arhitektura, pravila, stanje
- [docs/phases/](docs/phases/README.md) — razvojne faze in statusi
- [docs/design-guidelines.md](docs/design-guidelines.md) — oblikovna in UX pravila (nežen ton je sistemska zahteva)
- [docs/workflow.md](docs/workflow.md) — commit konvencije in review proces
- [CLAUDE.md](CLAUDE.md) — navodila za AI-asistiran razvoj

## Zasebnost in varnost

Vsi podatki uporabnice ostanejo na napravi (Hive/SharedPreferences).
Aplikacija je v podporo in ne nadomešča nasveta zdravnika ali pediatra —
disclaimer je del vsakega zaslona z otroško/zdravstveno vsebino.
