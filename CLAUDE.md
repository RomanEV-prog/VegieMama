# VegieMama — navodila za Claude

Flutter aplikacija za nosečnice in mamice (rastlinska prehrana, otrok do 3 let).

## Referenčni dokumenti (preberi pred večjim delom)

- `ARCHITECTURE.md` — arhitektura, pravila, stanje projekta
- `docs/phases/README.md` — načrt in status faz
- `docs/design-guidelines.md` — obvezna oblikovna/UX pravila (nežen ton!)
- `docs/workflow.md` — conventional commits, pr-review pred commitom

## Ukazi

```bash
flutter analyze          # mora biti čist pred vsakim commitom
flutter test             # widget testi; testno okolje: test/helpers/test_env.dart
flutter run -d emulator-5554 --release   # zagon na emulatorju
```

Nikoli ne poganjaj dveh `flutter` ukazov hkrati (startup lock deadlock).

Projektni skilli v `.claude/commands/`:
- `flutter-android-emulator` — adb recepti, zamrznitve, omrežje emulatorja
- `flutter-widget-testi` — FakeAsync/Hive/provider pasti v testih
- `flutter-gemini-klepet` — LLM klepet: vmesnik, .env asset, varnostna mreža
- `flutter-l10n` — gen-l10n: obseg (UI ogrodje vs vsebina), testni delegati

## Trda pravila

- Podatki v UI izključno prek providerjev (`context.watch`/`read`); mutacije prek repozitorijev.
- Vsi uporabniški teksti nežni, brez obsojanja (glej design-guidelines §6–7). UI ogrodje prek l10n (sl/en/de, context.l10n); vsebinski sloj (recepti, živila, empatična sporočila) je slovenski do v1.1.
- Commit sporočila: `type(scope): summary` (male črke, ≤50 znakov).
- Po vsaki zaključeni fazi: posodobi statuse v `docs/phases/` + `ARCHITECTURE.md`, commit, push.

## AI klepet (Gemini)

- Pravi AI teče prek Gemini API (`gemini-flash-latest` alias — NIKOLI konkretnih imen modelov, glej gotchas v greenheart skillu gemini-api). Ključ: `.env` v korenu (`GEMINI_API_KEY=...`, gitignoriran, bundlan kot asset — glej `.env.example`). **Brez `.env` build pade** (pubspec asset) — ustvari ga iz .env.example.
- Brez ključa (prazen .env) aplikacija samodejno pade nazaj na mock. Testi vedno tečejo na mocku.
