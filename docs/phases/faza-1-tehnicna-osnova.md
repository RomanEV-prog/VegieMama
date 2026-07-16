# Faza 1 – Tehnična osnova

**Status: ✅ končana**

## Cilj

Postaviti skelet aplikacije, na katerem vse nadaljnje faze gradijo brez preurejanja.

## Obseg (narejeno)

* [x] `pubspec.yaml` z odobrenim stackom (provider, go_router, hive, dio, intl, lottie)
* [x] mapna struktura po ARCHITECTURE.md
* [x] theme layer (`theme/`)
* [x] `app_router.dart` z bottom navigacijo (5 zavihkov) in ločenimi rutami (onboarding, settings, recipe detail)
* [x] provider bootstrap v `app.dart` (8 providerjev, vključno z izpeljanim `UserProgressProvider`)
* [x] vsi typed modeli (user, tracking, recipe, achievement, ai_assistant, baby_profile, premium_status)
* [x] mock storitve + repository sloj (providerji kličejo izključno repozitorije)
* [x] core widgeti: app bar, loading/empty/error state
* [x] l10n skeleton (sl, en, de)

## Znani dolgovi iz te faze

Prenesejo se v naslednje faze:

* `theme/theme.dart` in `theme/app_theme.dart` se prekrivata → poenotiti v Fazi 2
* zasloni so placeholderji → Faze 2–5
* persistence servisi obstajajo, a se ne uporabljajo → Faza 6
* hardcodani slovenski stringi → Faza 8
* prazne assets mape → polnijo se sproti po fazah
