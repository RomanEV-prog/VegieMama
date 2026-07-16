# Faza 5 – AI vertical slice

**Status: ⏸️ preskočena na zahtevo (16. 7. 2026) — AI klepet zaenkrat ostaja mock; vrnemo se po Fazi 7 ali 8, če bo potrebno**

## Cilj

Klepetalni zaslon z nežnim AI pomočnikom — najprej v celoti na mock odgovorih, s pripravljeno arhitekturo za pravi backend.

## Obseg

### Zasloni in widgeti (`screens/ai_assistant/widgets/`)

* [ ] `AIAssistantScreen` — klepet (flutter_chat_ui ali lastne komponente — odločitev ob začetku faze)
* [ ] `assistant_header.dart` — aktivni asistent (ime, avatar, vloga)
* [ ] `disclaimer_banner.dart` — stalen, nevsiljiv disclaimer: ne nadomešča zdravnika/pediatra
* [ ] `suggested_prompts.dart` — predlagana vprašanja za nežen vstop (ideje za obroke, počutje, B12 …)

### Tehnično

* [ ] `AIChatProvider`: pošiljanje, loading, retry, error state (nežno formuliran)
* [ ] `MockAIService`: smiselni vnaprej pripravljeni odgovori za tipična vprašanja
* [ ] pripraviti `services/remote/api_client.dart` + `ai_service.dart` kot vmesnik (interface), ki ga mock že implementira — priklop pravega backenda kasneje ne spremeni providerja
* [ ] varnostna pravila: AI nikoli ne diagnosticira; ob zdravstvenih vprašanjih nežno usmeri k zdravniku

## Sprejemni kriteriji

* Klepet deluje z mock odgovori, vključno z loading in error stanjem.
* Disclaimer je viden ob vstopu v klepet.
* Zamenjava mock → remote service ne zahteva sprememb v UI ali providerju (preverjeno s strukturo interface-a).
* `flutter analyze` brez napak.
