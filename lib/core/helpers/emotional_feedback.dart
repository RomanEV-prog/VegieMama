import 'dart:math';

/// Generates gentle, empathetic feedback messages
class EmotionalFeedback {
  EmotionalFeedback._();

  static final _random = Random();

  /// Gentle morning greetings
  static String morningGreeting(String name) {
    final greetings = [
      'Dobro jutro, $name 🌿',
      'Lepo jutro, $name! Kako si danes? 💚',
      'Nov dan, nove možnosti, $name 🌱',
      'Dobro jutro! Vesela sem, da si tu, $name 💚',
    ];
    return greetings[_random.nextInt(greetings.length)];
  }

  /// Gentle evening messages
  static String eveningMessage(String name) {
    final messages = [
      'Lep večer, $name 🌙',
      'Upam, da si imela lep dan, $name 💜',
      'Čas za počitek, $name. Zaslužiš si ga 🌙',
    ];
    return messages[_random.nextInt(messages.length)];
  }

  /// Water tracking encouragement
  static String waterProgress(double progress) {
    if (progress >= 1.0) {
      return 'Odlično! Danes si spila dovolj vode 💧';
    }
    if (progress >= 0.7) {
      return 'Super, skoraj si! Še malo vode 💧';
    }
    if (progress >= 0.4) {
      return 'Lepo napreduje! Nadaljuj po svojem tempu 💧';
    }
    return 'Vsak požirek šteje. Brez pritiska 💧';
  }

  /// Mood acknowledgment
  static String moodResponse(int rating) {
    if (rating >= 4) {
      return 'Lepo, da se dobro počutiš! 🌸';
    }
    if (rating >= 3) {
      return 'Hvala, da si delila. Vsak dan je drugačen 💚';
    }
    return 'Slišim te. Ni treba biti vedno ok. Tukaj sem zate 💜';
  }

  /// Motivational banner messages, gently tailored to the user's stage.
  /// [stage] matches UserType.name; null falls back to the shared pool.
  static String motivationalMessage([String? stage]) {
    const shared = [
      'Vsak korak šteje, tudi najmanjši 🌿',
      'Danes je dober dan za nežnost do sebe 🌸',
      'Ni popolnega dneva. Je pa tvoj dan. In to je dovolj 💚',
      'Rastlinska pot je pot ljubezni – do sebe in do sveta 🌱',
    ];
    const byStage = {
      'pregnant': [
        'Tvoje telo ve, kaj dela. Ti mu samo prisluhni 🤰',
        'Vsak teden zraseta oba – otrok in tvoja moč 💚',
        'Počitek ni razvada, je del nosečnosti 🌙',
      ],
      'postpartum': [
        'Okrevanje ni tekma. Tvoj tempo je pravi tempo 🌸',
        'Rodila si človeka. Danes je lahko kosilo čisto preprosto 💚',
        'Prositi za pomoč je znak moči, ne šibkosti 💜',
      ],
      'babyMom': [
        'Neprespane noči minejo. Tvoja nežnost ostane 🍼',
        'Dovolj dobra mama je natanko prava mama 💚',
        'Vsaka žlička je raziskovanje, ne izpit 🥄',
      ],
      'toddlerMom': [
        'Izbirčnost je faza, ne tvoja ocena 🧸',
        'Pester teden šteje več kot popoln dan 💚',
        'Malček raste – in ti rasteš z njim 🌱',
      ],
    };

    final pool = [...shared, ...?byStage[stage]];
    return pool[_random.nextInt(pool.length)];
  }
}
