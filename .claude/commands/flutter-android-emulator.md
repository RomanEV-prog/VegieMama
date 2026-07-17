# Flutter + Android emulator na tem računalniku (zagon, zamrznitve, adb recepti)

Iz seje VegieMama 16. 7. 2026 (Windows 11, Intel UHD, AVD Pixel_6 API 34).
Uporabi, kadar je treba aplikacijo pognati/preveriti na Android emulatorju
ali ko se emulator »ne odziva«.

## Zakaj / arhitektura

- `adb` NI na PATH v Git Bash — vedno polna pot:
  `"$LOCALAPPDATA/Android/Sdk/platform-tools/adb.exe"`
- Emulator binarka: `"$LOCALAPPDATA/Android/Sdk/emulator/emulator.exe"`
- Projekt ima NDK pripet v `android/app/build.gradle.kts`:
  `ndkVersion = "27.0.12077973"` (zahtevajo path_provider, shared_preferences,
  url_launcher). Brez tega Gradle ob vsakem buildu opozarja.

## Konkretni recepti

```bash
ADB="$LOCALAPPDATA/Android/Sdk/platform-tools/adb.exe"

# zagon emulatorja (flutter emulators --launch večkrat vrne prazen "exit 1";
# direktni klic pokaže pravi stderr in deluje enako)
"$LOCALAPPDATA/Android/Sdk/emulator/emulator.exe" -avd Pixel_6 &

# počakaj na POLNI boot (flutter devices pokaže napravo prezgodaj!)
until [ "$("$ADB" -s emulator-5554 shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')" = "1" ]; do sleep 3; done

# build + namestitev (prvi Gradle build ~7 min, naslednji ~2-3 min)
flutter run -d emulator-5554 --release   # v ozadju; kill procesa NE odstrani aplikacije

# ponovni zagon že nameščene aplikacije brez rebuilda
"$ADB" -s emulator-5554 shell am start -n com.example.veggiemama/.MainActivity

# posnetek zaslona
"$ADB" -s emulator-5554 exec-out screencap -p > screen.png

# pobrisanje podatkov aplikacije (za demo onboardinga / prvi zagon)
"$ADB" -s emulator-5554 shell pm clear com.example.veggiemama
```

## E2E verifikacija

- Aplikacija teče: v izpisu `flutter run` se pojavi `Installing ...apk` in
  nato `Using the Impeller rendering backend`.
- Fokus ima naša aplikacija:
  `"$ADB" shell dumpsys window | grep mCurrentFocus` →
  `com.example.veggiemama/...MainActivity`.

## Gotchas

- **»UI se ne odziva«** → najprej `dumpsys window | grep mCurrentFocus`.
  Če piše `Application Not Responding: com.android.systemui`, je zamrznil
  SISTEMSKI UI emulatorja (ne aplikacija) in ANR dialog požira ves vnos.
- **Navaden restart emulatorja NE pomaga pri zamrznitvi** — quick-boot
  snapshot obnovi točno zamrznjeno stanje (isti window hash!). Rešitev:
  `"$ADB" emu kill` + zagon z `-no-snapshot-load` (hladni zagon).
- **Emulator med dolgim Gradle buildom lahko izgine** (`device ... not found`
  pri Installing) — po buildu preveri `flutter devices` in po potrebi znova
  zaženi emulator; APK je zgrajen, ponovni `flutter run` je hiter.
- `flutter emulators --launch Pixel_6` vrne `exited with code 1` tudi, kadar
  emulator že teče — najprej preveri `flutter devices`.
- `flutter run --release` ostane pripet na terminal; prekinitev procesa ne
  odstrani aplikacije (release build teče naprej samostojno).

## Dopolnitev (seja 17. 7. 2026 — omrežje emulatorja)

- **`ping` na emulatorju je NEUPORABEN test** — SLIRP omrežje pogosto blokira
  ICMP, TCP pa dela. Pravi test:
  `"$ADB" shell "toybox nc -w 5 <host> 443 </dev/null && echo TCP_OK"`.
- **Omrežje emulatorja občasno odmre** (connectionTimeout v aplikaciji,
  TCP_FAIL) — popravi brez restarta:
  `"$ADB" shell "svc wifi disable"; sleep 2; "$ADB" shell "svc wifi enable"`.
  Če ne pomaga: zaženi emulator z `-dns-server 8.8.8.8,1.1.1.1`.
- **Release build NIMA INTERNET dovoljenja** — debug/profile manifest ga
  dodata samodejno, `src/main/AndroidManifest.xml` pa ne. Simptom: vsi
  HTTP klici padejo SAMO v release buildu. Dodaj:
  `<uses-permission android:name="android.permission.INTERNET"/>`.
