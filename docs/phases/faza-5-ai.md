# Faza 5 – AI vertical slice

**Status: ✅ končana (17. 7. 2026)**

## Cilj

Klepetalni zaslon z nežnim AI pomočnikom — najprej v celoti na mock odgovorih, s pripravljeno arhitekturo za pravi backend.

## Obseg

### Zasloni in widgeti (`screens/ai_assistant/widgets/`)

* [x] `AIAssistantScreen` — klepet (flutter_chat_ui ali lastne komponente — odločitev ob začetku faze)
* [x] `assistant_header.dart` — aktivni asistent (ime, avatar, vloga)
* [x] `disclaimer_banner.dart` — stalen, nevsiljiv disclaimer: ne nadomešča zdravnika/pediatra
* [x] `suggested_prompts.dart` — predlagana vprašanja za nežen vstop (ideje za obroke, počutje, B12 …)

### Tehnično

* [x] `AIChatProvider`: pošiljanje, loading, retry, error state (nežno formuliran)
* [x] `MockAIService`: smiselni vnaprej pripravljeni odgovori za tipična vprašanja
* [x] pripraviti `services/remote/api_client.dart` + `ai_service.dart` kot vmesnik (interface), ki ga mock že implementira — priklop pravega backenda kasneje ne spremeni providerja
* [x] varnostna pravila: AI nikoli ne diagnosticira; ob zdravstvenih vprašanjih nežno usmeri k zdravniku

## Sprejemni kriteriji

* Klepet deluje z mock odgovori, vključno z loading in error stanjem.
* Disclaimer je viden ob vstopu v klepet.
* Zamenjava mock → remote service ne zahteva sprememb v UI ali providerju (preverjeno s strukturo interface-a).
* `flutter analyze` brez napak.

## Opombe ob zaključku

* Klepet je zgrajen z **lastnimi komponentami** (mehurčki, typing indikator, predlogi), ne s `flutter_chat_ui` — paket je bil zastarel in vizualno neskladen z design sistemom; odstranjen iz pubspec.
* **Vsaka pomočnica ima ločen pogovor** — preklop med Lino, Majo in Zalo ohrani kontekst.
* **Varnostna pravila v mocku:** zdravstvene ključne besede (bolečina, krvavitev, zdravila, izpuščaj ...) vedno sprožijo preusmeritev k zdravniku/112; AI nikoli ne diagnosticira.
* `services/remote/`: `AIService` vmesnik + `ApiClient` (Dio) + `RemoteAIService` skelet — priklop pravega backenda je ena vrstica v `AIRepository`, brez sprememb v UI/providerju.
* **Nadgradnja (17. 7. 2026):** klepet zdaj teče na pravem modelu prek Gemini API (`gemini-flash-latest`, recepti in pasti iz greenheart skilla `gemini-api`): sistemske persone za Lino/Majo/Zalo, zgodovina pogovora (zadnjih 12 sporočil), maxOutputTokens 2048, retry na 503. Deterministična varnostna mreža (AISafety) prestreže zdravstvena vprašanja PRED klicem modela. Ključ v `.env` (gitignoriran); brez ključa mock fallback.
