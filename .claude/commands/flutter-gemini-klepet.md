# Gemini klepet v Flutter aplikaciji (persone, .env, mock fallback)

Iz seje VegieMama 17. 7. 2026: priklop pravega LLM klepeta (Gemini) v
Flutter aplikacijo s Provider arhitekturo. Razmejitev: skill
`gemini-api` (greenheart) pokriva API pasti (modeli, kvote, vision);
ta skill pokriva KAKO se klepet arhitekturno vgradi v Flutter app.

## Zakaj / arhitektura

- **Vmesnik + dve implementaciji:** `abstract class AIService`
  (getAssistants, sendMessage z `history`), implementirata ga
  `MockAIService` in `GeminiAIService`. Repository izbere backend v ENI
  vrstici: `EnvConfig.hasGemini ? GeminiAIService() : MockAIService()`.
  Testi tako VEDNO tečejo na mocku (EnvConfig se v testih ne naloži),
  aplikacija brez ključa pa se nežno degradira namesto sesuje.
- **Ključ kot .env asset, brez paketov:** `.env` v korenu (gitignoriran,
  `.env.example` commitan), v pubspec `assets: - .env`, ročni parser
  prek `rootBundle.loadString('.env')` v try/catch. POZOR: pubspec
  asset, ki ne obstaja, PODRE build — svež klon mora ustvariti .env.
- **Brez `google_generative_ai` paketa** — navaden Dio POST na
  `v1beta/models/gemini-flash-latest:generateContent?key=...` zadošča.
- **Varnostna mreža PRED modelom:** deterministični keyword filter
  (`AISafety.isMedical`) prestreže zdravstvena vprašanja in vrne fiksno
  preusmeritev k zdravniku — ne zanašaj se samo na system prompt.

## Konkretni recepti

### Telo zahteve (persona + zgodovina)
```dart
final body = {
  'system_instruction': {'parts': [{'text': '$persona\n\n$pravila'}]},
  'contents': [
    for (final m in zadnjih12) {'role': m.isUser ? 'user' : 'model',
        'parts': [{'text': m.content}]},
    {'role': 'user', 'parts': [{'text': message}]},
  ],
  'generationConfig': {'maxOutputTokens': 2048, 'temperature': 0.7},
};
```
- V skupna pravila NUJNO: »Piši navadno besedilo BREZ markdown oznak
  (brez **, *, #); sezname piši z vezaji.« — sicer UI kaže gole `**`.
- Zgodovino omeji (npr. zadnjih 12 sporočil) in jo zajemi PRED
  dodajanjem novega user sporočila v provider.

### Provider vzorec (nežen retry)
- Ob napaki odstrani neodgovorjeno user sporočilo iz pogovora in shrani
  `failedMessage`; UI pokaže nežno vrstico + gumb Poskusi znova, ki
  kliče `sendMessage(failedMessage)`.
- En pogovor NA pomočnico (`Map<String, List<ChatMessage>>`) — preklop
  person ohrani kontekst.
- V UI pod nežnim sporočilom pokaži droben tehnični vzrok
  (`provider.error`, font 10, textLight) — release build je sicer slep.

## E2E verifikacija

1. Točen klic reproduciraj iz PowerShell (glej gemini-api skill) — če
   host vrne `finishReason: STOP`, je koda/API OK in je problem naprava.
2. Na napravi: vprašanje, ki ga mock NE pozna (npr. »Kaj naj spakiram v
   torbo za porodnišnico?«) → vsebinski odgovor = pravi model.
3. Zdravstveno vprašanje (»boli me...«) → fiksna preusmeritev, model se
   sploh ne kliče.

## Gotchas

- **Release build brez INTERNET dovoljenja** — vsi klici padejo samo v
  release; dodaj `<uses-permission android:name="android.permission.INTERNET"/>`
  v `src/main/AndroidManifest.xml` (debug/profile ga imata samodejno).
- **429 takoj po nekaj testnih klicih** = free-tier RPM limit, počakaj
  minuto (podrobno v gemini-api skillu).
- **connectionTimeout na emulatorju** = omrežje emulatorja, ne koda —
  `svc wifi disable/enable` (glej flutter-android-emulator skill).
- Widget testi z realnim backendom bi klicali internet — zato mock
  fallback prek EnvConfig, ki se v testnem okolju nikoli ne napolni.
