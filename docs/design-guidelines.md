# VeggieMama – oblikovne in UX smernice

Sinteza uporabniških skillov (refactoring-ui, web-typography, ux-heuristics, microinteractions, hooked-ux, frontend-design, android) — prilagojena za Flutter in za produktna načela VeggieMama iz [ARCHITECTURE.md](../ARCHITECTURE.md). Te smernice so obvezne od Faze 2 dalje; vsak nov zaslon se pred zaključkom oceni po kontrolnih seznamih spodaj.

---

## 1. Oblikovna smer (frontend-design)

Preden se piše koda, mora biti jasna estetska smer. Za VeggieMama je določena:

* **Ton:** soft/organic — mehko, toplo, rastlinsko; nikoli sterilno »medicinsko« in nikoli otročje.
* **Diferenciator:** nežnost kot sistem — vse (barve, animacije, besedila, prazna stanja) sporoča »tukaj si varna«.
* **Anti-vzorci, ki jih ne delamo:** generični AI videz, vijolični gradienti, vse centrirano, vse enake velikosti, hladna klinična bela.

## 2. Vizualna hierarhija in razmiki (refactoring-ui)

* **Najprej sivine, barva zadnja.** Hierarhija mora delovati brez barve (squint test).
* Hierarhija prek **velikosti, teže in barve** — kombiniraj eno ali dve, ne vseh treh hkrati.
* Labele so podrejene vrednostim: manjše, svetlejše.
* **Lestvica razmikov:** samo 4, 8, 16, 24, 32, 48, 64 (`app_spacing.dart` mora vsebovati točno te vrednosti; nobenih poljubnih 13/17/22).
* Razmik med skupinami > razmik znotraj skupine. Začni s preveč belega prostora, potem odvzemaj.
* Sence po namenu: gumb < kartica < bottom sheet < dialog. Senca = prosojna temna, ne siva.
* Besedilni bloki: največ ~65 znakov širine.
* Prazna stanja so priložnost za ilustracijo in nežno sporočilo, ne »Ni podatkov«.

## 3. Tipografija (web-typography)

* **Osnovno besedilo ≥ 16 (bodyLarge), line-height 1.5–1.75.** Nikoli teže pod 400 za body.
* Modularna lestvica (1.25): 12, 14, 16, 20, 24, 30, 36 → definirana enkrat v `app_text_theme.dart`.
* **Največ 2 družini pisav.** Izbrana pisava mora imeti popoln nabor znakov za **č, š, ž** in nemške preglase — obvezno preveriti pred uvedbo.
* Priporočena smer: mehka humanistična sans (npr. Nunito/Quicksand razred) za naslove + čitljiva sans za body; končna izbira ob Fazi 2.
* Hierarhija: med sosednjima nivojema vsaj 1.25× velikosti ali očitna razlika v teži.

## 4. Barve (refactoring-ui + Material 3)

* Vsaka glavna barva v 5–9 odtenkih (50–900) v `app_colors.dart`; UI uporablja odtenke, ne surove barve.
* Sivine z rahlo toplo/zeleno saturacijo — čiste sive so mrtve.
* **Kontrast body besedila ≥ 4.5:1 (WCAG AA)** — velja tudi za dark theme.
* Semantika brez alarma: tudi »opozorilna« stanja v nežnih tonih (jantarna, ne kričeče rdeča); rdeča samo za destruktivna dejanja.

## 5. Mikrointerakcije (microinteractions)

Vsaka interakcija ima 4 dele: sprožilec → pravila → povratna informacija → zaključek.

**Časovnice (Flutter `Duration`):**
* takojšnje (<100 ms): pritisk gumba, checkbox
* hitro (100–300 ms): hover/tap efekti, prehodi kartic
* srednje (300–500 ms): prehodi zaslonov, bottom sheet
* počasi (500 ms+): samo za poudarek (odklep dosežka, Lottie) — redko

**Easing:** vstop `Curves.easeOutCubic` (ali `easeOutExpo`), izstop `Curves.easeIn`. Nikoli `linear`.

**Obvezna stanja za vsako podatkovno komponento:** loading (skeleton, ne samo spinner), empty (ilustracija + nežno besedilo), error (nežno, z možnostjo »poskusi znova«), success.

**Pravila za VeggieMama:**
* Quick add (voda, obrok) mora dati takojšnjo vidno in taktilno potrditev (animacija + `HapticFeedback.lightImpact`).
* Napačen vnos se nikoli ne »strese« agresivno — nežen prehod barve in prijazno inline sporočilo ob polju (validacija on blur, ne on keypress).
* Največ 2–3 stvari animirane hkrati; samo `transform`/`opacity` ekvivalenti (Flutter: `AnimatedScale`, `FadeTransition`), da ni janka.
* Vsak spinner/progress ima jasen konec (uspeh ali nežna napaka) — brez neskončnih zank.

## 6. UX hevristike (ux-heuristics — Nielsen + Krug)

»Don't make me think« — uporabnica skenira, ne bere; pogosto z eno roko in z dojenčkom v drugi.

Kontrolni seznam za vsak zaslon (ocena 0–10, cilj ≥ 8 pred zaključkom faze):

1. **Vidnost stanja** — vedno jasno, kaj se dogaja (loading, shranjeno, sinhronizirano).
2. **Jezik uporabnice** — brez žargona; »teden nosečnosti«, ne »gestacijska starost«.
3. **Nadzor in svoboda** — vse se da preskočiti, razveljaviti, zapreti; onboarding ima »preskoči«.
4. **Konsistentnost** — isti pojmi in vzorci povsod; Material konvencije.
5. **Preprečevanje napak** — potrditev pred brisanjem podatkov; smiselne privzete vrednosti.
6. **Prepoznavanje, ne pomnjenje** — vse vidno, nič ni treba pomniti.
7. **Fleksibilnost** — quick add za vsakodnevno rabo, podroben vnos za tiste, ki želijo.
8. **Minimalizem** — odstrani ~50 % besed; vsak dodaten element tekmuje s pomembnimi.
9. **Okrevanje po napaki** — sporočila: kaj se je zgodilo + kaj lahko naredi, v nežnem tonu.
10. **Pomoč** — kontekstualna, kratka, ob nalogi.

**Navigacija:** uporabnica mora vedno vedeti »kje sem, kam lahko grem, kako nazaj«. Aktivni zavihek jasno označen.

**Temni vzorci so prepovedani** — še posebej za premium: brez skritega preklica, brez vnaprej odkljukanih opcij, brez lažne nujnosti. To je pri ranljivi ciljni skupini (nosečnice, sveže mamice) absolutno pravilo.

## 7. Nežna zvestoba namesto zasvojenosti (hooked-ux, etično prilagojeno)

Hook model uporabimo **samo v kvadrantu Facilitator**: produkt mora dejansko izboljševati življenje. VeggieMama gradi nežno rutino, ne odvisnosti.

* **Notranji sprožilec:** negotovost (»ali jaz/otrok dobiva dovolj hranil?«) in potreba po pomiritvi. Aplikacija je odgovor na to čustvo — z informacijo in pomiritvijo, nikoli s podpihovanjem strahu.
* **Akcija:** prva vrednost v < 60 sekundah (onboarding pokaže personaliziran vpogled takoj po izbiri faze). Quick add = en dotik. Zmanjšuj trenje, ne povečuj pritiska.
* **Variabilna nagrada (Self, nežno):** rotirajoča nežna sporočila, mikro-presenečenja ob vnosih, dosežki. **Brez streak-ov s kaznijo** — prekinjen niz se nikoli ne komentira negativno.
* **Investicija:** profil, zgodovina vnosov, favoriti — podatki delajo aplikacijo bolj osebno. Investicijo prosimo šele PO prvi nagradi (onboarding najprej da, šele nato vpraša).
* **Prepovedano:** FOMO mehanike, socialna primerjava, guilt-trip notifikacije (»Pogrešamo te!«), umetna redkost.

## 8. Android / izdaja (android skill — relevantni del za Flutter)

Kotlin/Compose del skilla za ta projekt ni relevanten (Flutter), velja pa Play Store checklist za Fazo 8:

* min SDK 26+, AAB (ne APK), keystore ustvarjen enkrat in varno shranjen, versionCode +1 ob vsaki objavi
* store listing: naziv ≤ 30 znakov, kratek opis ≤ 80, ikona 512×512, feature graphic 1024×500, min 2 posnetka zaslona
* obvezna zasebnostna politika (URL) — pri zdravstvenih podatkih še posebej skrbno
* content rating vprašalnik; pri vsebini o nosečnosti/otrocih preveri Play politike za zdravstvene aplikacije

## 9. Kontrolni seznam pred zaključkom vsakega zaslona

* [ ] deluje v sivinah (hierarhija brez barve)
* [ ] samo vrednosti iz spacing/type lestvice
* [ ] loading + empty + error + success stanja
* [ ] mikrointerakcije s pravilnimi časovnicami in easingom
* [ ] Nielsen ocena ≥ 8/10
* [ ] besedila: nežna, brez obsojanja, brez žargona, ~50 % manj besed kot prvi osnutek
* [ ] uporabno z eno roko (ključne akcije v dosegu palca)
* [ ] kontrast AA v light in dark temi
* [ ] brez temnih vzorcev
