# VeggieMama – arhitektura projekta (v2)

> Posodobljeno: 17. 7. 2026. Ta dokument nadomešča prejšnjo datoteko `md` in je referenčna osnova za nadaljnji razvoj. Podrobni načrti po fazah so v `docs/phases/`. Oblikovna in UX pravila: [docs/design-guidelines.md](docs/design-guidelines.md). Delovni proces (commiti, review, triage napak): [docs/workflow.md](docs/workflow.md).

## Namen dokumenta

Ta dokument določa enotno arhitekturo za razvoj aplikacije **VeggieMama**. Namenjena je temu, da vsi sodelujoči AI-ji in razvijalci delajo po isti strukturi, brez improvizacije in brez poznejšega večjega preurejanja.

VeggieMama je mobilna Flutter aplikacija za:

* nosečnice,
* mamice po porodu,
* mamice z dojenčkom,
* **mamice z malčkom do 3. leta starosti** (razširitev v2),
* uporabnice, ki želijo podporo pri rastlinski prehrani, počutju, rutini, dojenju, uvajanju hrane, prehrani malčka in nežni AI podpori.

---

## 1. Produktna usmeritev

### Osnovna produktna obljuba

VeggieMama ni samo tracking aplikacija. Je:

* empatična digitalna spremljevalka,
* varen prostor brez pritiska,
* pomoč pri vsakodnevnih odločitvah,
* personaliziran sistem podpore glede na fazo uporabnice — **od nosečnosti do 3. leta otroka**.

### Življenjski lok uporabnice (v2)

Aplikacija spremlja uporabnico skozi štiri faze in se ji prilagaja:

1. **Nosečnost** – rast otroka po tednih, prehranska podpora, počutje.
2. **Po porodu** – okrevanje, dojenje, nežna rutina.
3. **Dojenček (0–12 mesecev)** – dojenje/hranjenje, uvajanje goste hrane (~6 mesecev), rast in mejniki.
4. **Malček (1–3 leta)** – uravnotežena rastlinska prehrana, jedilniki, kritični nutrienti (B12, železo, cink, jod, omega-3, vitamin D, kalcij, beljakovine), izbirčnost, rast.

Prehod med fazami je samodejen (izračun iz PDP/datuma rojstva), a uporabnica ga lahko vedno ročno prilagodi. Nobena funkcionalnost ne izgine ob prehodu — samo poudarki na Home/Tracking se spremenijo.

### UX načela, ki veljajo absolutno povsod

Vsak ekran, komponenta, tekst in AI odgovor mora biti:

* nežen,
* pomirjujoč,
* jasen,
* brez obsojanja,
* brez tekmovalnosti,
* prilagojen obdobju uporabnice,
* uporaben tudi z eno roko,
* z nizko kognitivno obremenitvijo.

To ni dodatna plast. To je osnova arhitekture.

### Zdravstvena varnost (v2)

* Vsa prehranska vsebina za otroke 0–3 let mora imeti jasen disclaimer, da ne nadomešča pediatra.
* AI pomočnik nikoli ne daje medicinskih diagnoz ali navodil za zdravljenje.
* Vsebine o uvajanju hrane sledijo uveljavljenim smernicam (WHO, nacionalne smernice); vir se navede v vsebinskem sloju, ne v kodi.

---

## 2. Arhitekturne odločitve

### Primarni stack

* **Flutter** za mobilno aplikacijo
* **Provider** za state management
* **go_router** za navigacijo
* **Hive / SharedPreferences** za lokalno shranjevanje
* **Dio** za API komunikacijo
* **flutter_localizations + intl** za večjezičnost
* **Lottie** za dosežke, mikrointerakcije in avatar odzive
* po potrebi kasneje: backend integracije, AI webhooki, n8n, analytics

### Ključna pravila arhitekture

1. **UI ne sme vsebovati poslovne logike**, razen lokalne prezentacijske logike.
2. **Domenski podatki naj bodo typed modeli**, ne `Map<String, dynamic>` v widgetih, razen začasno v mock fazi.
3. **Providerji vodijo state**, widgeti samo prikazujejo stanje in pošiljajo akcije.
4. **Services** so odgovorni za podatke, mocke, API klice in persistence.
5. **Repositories** so edina vez med providerji in services — provider nikoli ne kliče mock/local/remote neposredno.
6. **Core/helpers** vsebuje helperje, formatterje, emotional feedback generatorje, validacije.
7. **Theme in l10n** morata biti centralizirana.
8. **Vsaka komponenta je v svoji datoteki.**
9. **Empathy UX** se obravnava kot sistemska zahteva, ne kot copywriting dodatek.

---

## 3. Trenutno stanje (julij 2026)

Kaj je narejeno:

* ✅ mapna struktura po tem dokumentu,
* ✅ vsi typed modeli (user, tracking, recipe, achievement, ai_assistant, baby_profile, premium_status),
* ✅ provider bootstrap v `app.dart`, vključno z izpeljanim `UserProgressProvider`,
* ✅ go_router z bottom navigacijo (5 zavihkov) + ločene rute (onboarding, settings, recipe detail),
* ✅ repository sloj, providerji kličejo repozitorije, mocki so skriti za njimi,
* ✅ theme layer, osnovni core widgeti (app bar, loading/empty/error state).

Dopolnjeno do konca MVP (17. 7. 2026):

* ✅ AI klepet na pravem modelu (Gemini, gemini-flash-latest) z deterministično varnostno mrežo; mock fallback brez ključa,
* ✅ persistence deluje (Hive za user/tracking/favorites, SharedPreferences za temo/jezik),
* ✅ l10n: UI ogrodje v sl/en/de; vsebinski sloj (recepti, živila, empatija) namenoma sl do v1.1,
* ✅ `services/remote/` vmesnik pripravljen (AIService, ApiClient, RemoteAIService) — priklop backenda je ena vrstica,
* ✅ 26 testov: Profil, Sledenje, Recepti, onboarding/persistenca, otrok 0–3, AI klepet in helperji,
* ✅ app ikona in splash (generirana, brand barve); assets mape se polnijo po potrebi,
* ✅ onboarding je vezan na začetni flow (router redirect),
* ✅ applicationId com.romanev.veggiemama + signing prek key.properties (keystore je ročni korak — glej v1.1 načrt).

Odprto za naslednjo iteracijo: [docs/phases/v1.1-nacrt.md](docs/phases/v1.1-nacrt.md).

---

## 4. Ciljni MVP

## MVP v1.0 – obvezne funkcionalnosti

### A. Onboarding in profil uporabnice

* osnovni onboarding
* izbira tipa uporabnice:
  * nosečnica
  * mamica po porodu
  * mamica z dojenčkom
  * **mamica z malčkom (1–3 leta)**
* vnos osnovnih podatkov: ime, PDP ali datum rojstva otroka, faza dojenja, prehranske preference, cilji uporabe aplikacije
* osnovne nastavitve jezika in teme

### B. Profil

* prikaz osebnih podatkov
* izračun tedna nosečnosti ali starosti otroka (meseci/leta)
* prikaz nežnega napredka
* povezava do AI asistentov
* dosežki
* premium status
* nastavitve

### C. Dnevno sledenje

* tekočine, obroki, počutje, spanje, vitamini/dodatki
* dojenje ali hranjenje (faza dojenček)
* **obroki malčka in pokritost ključnih nutrientov (faza malček)**
* quick add interakcije

### D. Recepti

* seznam receptov, najljubši, nedavno pripravljeni
* osnovni filtri
* oznake: nosečnost, dojenje, uvajanje hrane, **malček 1–3**, železo, B12, hitri obroki

### E. AI pomočnik

* osnovni klepetalni zaslon
* nežni odgovori, prehranska podpora, ideje za obroke
* osnovna čustvena podpora z jasnim disclaimerjem, da ne nadomešča zdravnika/pediatra

### F. Otrok 0–3 (razširitev v2, MVP vključi osnovo)

* profil otroka (ime, datum rojstva, opombe o alergijah)
* prikaz starosti in faze (uvajanje hrane / malček)
* osnovni vodnik uvajanja hrane po starosti
* jedilniki in recepti, filtrirani po starosti otroka

### G. Lokalizacija

* slovenščina, angleščina, nemščina
* arhitektura pripravljena za dodatne jezike

## Funkcionalnosti po MVP-ju

### Verzija 1.1+

* podrobnejši tracker dojenja in hranjenja
* podroben tracker uvajanja živil (katera živila že uvedena, reakcije)
* AI meal planner (tudi za malčka)
* tedenska poročila, izvoz podatkov
* rastne krivulje (percentili) z nežnim prikazom
* biometrično zaklepanje, health platforme
* več AI asistentov z avatarji
* premium paketi in plačila

### Verzija 1.2+

* skupnost
* vsebine po tednih (nosečnost) in mesecih (otrok)
* programi za počutje po porodu
* push obvestila z nežnim tonom
* napredna analitika navad
* OCR / scan za živila, če bo relevantno

---

## 5. Mapna struktura

```text
lib/
├── main.dart
├── app.dart
│
├── core/
│   ├── constants/        # app_colors, app_spacing, app_radius, app_strings
│   ├── errors/           # app_exception, error_handler
│   ├── helpers/          # emotional_feedback, date_helper, format_helper, validation_helper
│   └── widgets/          # veggie_mama_app_bar, loading/empty/error state
│
├── routes/
│   └── app_router.dart
│
├── theme/                # app_theme, app_text_theme, app_color_scheme
├── l10n/                 # app_sl.arb, app_en.arb, app_de.arb
│
├── models/
│   ├── user_model.dart
│   ├── baby_profile_model.dart
│   ├── tracking_data_model.dart
│   ├── achievement_model.dart
│   ├── recipe_model.dart
│   ├── ai_assistant_model.dart
│   ├── premium_status_model.dart
│   └── food_introduction_model.dart      # NOVO (Faza 7)
│
├── services/
│   ├── mock/             # mock_user, mock_tracking, mock_recipe, mock_ai
│   ├── local/            # storage_service (Hive), preferences_service (SharedPreferences)
│   ├── remote/           # api_client, ai_service, recipe_service (še ne obstaja)
│   └── repositories/     # user, tracking, recipe, ai (+ baby v Fazi 7)
│
├── providers/
│   ├── user_provider.dart
│   ├── tracking_provider.dart
│   ├── achievements_provider.dart
│   ├── recipes_provider.dart
│   ├── ai_chat_provider.dart
│   ├── theme_provider.dart
│   ├── locale_provider.dart
│   ├── user_progress_provider.dart
│   └── baby_provider.dart                # NOVO (Faza 7)
│
├── screens/
│   ├── onboarding/  + widgets/
│   ├── home/        + widgets/
│   ├── profile/     + widgets/
│   ├── tracking/    + widgets/
│   ├── recipes/     + widgets/
│   ├── ai_assistant/+ widgets/
│   ├── baby/        + widgets/           # NOVO (Faza 7): profil otroka, uvajanje hrane
│   └── settings/    + widgets/
│
└── widgets/          # samo res reusable: motivational_banner, achievement_badge,
                      # section_title, primary_action_button, info_card
```

### Pravilo za widgete

Feature-specific widgeti živijo v `screens/<feature>/widgets/`, globalni `widgets/` vsebuje samo res reusable komponente. Obstoječi profilni widgeti v globalnem `lib/widgets/` (profile_header, tracking_summary, premium_status_card, ai_assistants_section, favorite_recipes_section, settings_section) se ob implementaciji Faze 2 preselijo v `screens/profile/widgets/`.

---

## 6. Navigacijska arhitektura

### Primarna navigacija

**BottomNavigationBar** s 5 glavnimi točkami: Home, Tracking, Recepti, AI, Profil.

Vsebine za otroka (profil otroka, uvajanje hrane) so dostopne prek Home in Profila — ne dodajamo šestega zavihka.

### Rute

```text
/                  # home
/tracking
/recipes
/recipes/:id
/ai
/profile
/settings
/onboarding
/baby              # NOVO (Faza 7) – profil otroka
/baby/food-guide   # NOVO (Faza 7) – vodnik uvajanja hrane
```

### Pravila

* glavni flow je preko `go_router`,
* detajlni zasloni se odpirajo izven shell-a (z back gumbom),
* bottom navigation obstaja samo na glavnih root screenih,
* onboarding je ločen flow; **redirect na `/onboarding`, dokler uporabnica ni ustvarjena** (Faza 6).

---

## 7. State management

### Providerji

| Provider | Odgovornost |
|---|---|
| `UserProvider` | current user, user type, nosečnost/poporodni meta podatki, onboarding completion |
| `TrackingProvider` | današnji podatki, tedenski podatki, quick add, loading state |
| `AchievementsProvider` | seznam dosežkov, progress, unlock logika |
| `RecipesProvider` | seznam, favorites, recent, filter stanje (vključno s filtrom po starosti otroka) |
| `AIChatProvider` | sporočila, aktivni asistent, loading/retry/error, conversation context |
| `ThemeProvider` | light / dark / system |
| `LocaleProvider` | aktivni jezik |
| `UserProgressProvider` | derived state: napredek tekočin, ciljev, blagi summary indikatorji |
| `BabyProvider` (Faza 7) | profil otroka, starost/faza, stanje uvajanja hrane |

### Pravila

Providerji naj bodo majhni, pregledni, osredotočeni na en domain, brez UI kode. Vsaka mutacija, ki mora preživeti restart aplikacije, gre prek repozitorija v persistence (Faza 6).

---

## 8. Podatkovni modeli

### `UserModel`

id, firstName, lastName, userType (pregnant / postpartum / infant / **toddler**), dueDate, birthDate, babyAgeInMonths, dailyWaterGoal, preferredLanguage, isPremium, premiumUntil, avatarPath

### `BabyProfileModel` (razširjen v Fazi 7)

id, name, birthDate, allergies, notes, izpeljano: ageInMonths, stage (newborn / introducing / toddler)

### `TrackingDataModel`

date, waterIntake, waterGoal, sleepHours, sleepGoal, moodRating, mealsLogged, vitamins, breastfeedingSessions, notes (+ v Fazi 7: babyMeals, nutrientCoverage)

### `AchievementModel`

id, title, description, icon, currentCount, requiredCount, isUnlocked, unlockedAt

### `RecipeModel`

id, title, tags, isFavorite, isRecent, suitableFor (vključno s starostnimi razponi otroka), nutrientsHighlights

### `AIAssistantModel`

id, name, role, avatarAsset, introText, lastConversationPreview

### `FoodIntroductionModel` (NOVO, Faza 7)

foodId, name, category, recommendedFromMonth, introduced, introducedAt, reaction, notes

---

## 9. Razvojne faze

Podroben načrt vsake faze je v `docs/phases/faza-N-*.md`; načrt naslednje iteracije v `docs/phases/v1.1-nacrt.md`. Povzetek:

| Faza | Vsebina | Status |
|---|---|---|
| 1 | Tehnična osnova: pubspec, theme, router, providerji, modeli, mocki | ✅ končana |
| 2 | Profile vertical slice | ✅ končana |
| 3 | Tracking vertical slice | ✅ končana |
| 4 | Recipes vertical slice | ✅ končana |
| 5 | AI vertical slice | ✅ končana |
| 6 | Onboarding + persistence | ✅ končana |
| 7 | Otrok 0–3: profil otroka, uvajanje hrane, prehrana malčka | ✅ končana |
| 8 | Polish: l10n, testi, dosežki, priprava na izdajo | ✅ končana |

Vrstni red faz 2–6 sledi prvotnemu dokumentu; faza 7 (otrok 0–3) pride za persistence, ker potrebuje shranjen profil otroka; faza 8 je čiščenje pred izdajo.

---

## 10. Vloga AI-jev v projektu

**Claude**: piše čiste Flutter komponente, nežne in empatične tekste, modularno kodo; uporablja obstoječe modele in providerje; ne spreminja arhitekture po svoje. Claude ne določa strukture projekta — sledi ji.

**Cursor**: ustvarja in povezuje datoteke, skrbi za routing in integracijo, usklajuje providerje, teme, navigacijo, popravlja uvoze; ne uvaja novih smeri brez potrditve.

**Vodja projekta**: validacija vseh predlogov, zavrnitev odstopanj, skrb za konsistentnost, postopna gradnja brez tehničnega dolga.

---

## 11. Pravila implementacije

### Obvezna pravila

* brez hardcoded stringov v final produkcijski kodi — vse gre prek l10n, ko komponenta preide iz prototipa v produkcijski nivo
* brez business logike v widgetih
* brez direktnega klica mock service iz UI komponent
* brez naključnega preimenovanja datotek in map
* brez uvajanja novih paketov brez potrditve
* brez agresivnih error message-ov

### UX pravila

* nikoli »nisi dosegla cilja«
* nikoli »napaka« v hladnem tonu
* nikoli primerjava z drugimi uporabnicami
* vedno možnost preskoka, pasivne uporabe ali nežnega vstopa

### Vsebinska pravila za otroka 0–3 (v2)

* nikoli strašenja (»če otrok ne dobi X, se zgodi Y«)
* vedno disclaimer pri prehranskih priporočilih za otroka
* izbirčnost se obravnava kot normalna faza, ne kot problem
* brez primerjave otrokove rasti z »normalnimi« otroki — percentili so informacija, ne ocena

---

## 12. Zaključek

VeggieMama v2 temelji na štirih slojih:

1. **čustveno varen produkt**,
2. **modularna Flutter struktura**,
3. **priprava na rast brez rušenja osnove**,
4. **kontinuiteta od nosečnosti do 3. leta otroka**.

Ta dokument je referenčna osnova za nadaljnji razvoj.
