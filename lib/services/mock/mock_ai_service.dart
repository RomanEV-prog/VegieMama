import '../../models/ai_assistant_model.dart';
import '../../models/chat_message_model.dart';
import '../ai_safety.dart';
import '../remote/ai_service.dart';

/// Mock AI backend: gentle, keyword-based answers per assistant.
/// Safety first — medical-sounding questions always redirect to a
/// doctor/pediatrician, never a diagnosis.
class MockAIService implements AIService {
  @override
  Future<List<AIAssistantModel>> getAssistants() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      AIAssistantModel(
        id: 'ai_nutrition',
        name: 'Lina',
        role: 'Prehranska svetovalka',
        avatarAsset: 'assets/icons/ai_nutrition.png',
        introText:
            'Pomagam ti s prehranskimi vprašanji v rastlinski prehrani 🌿',
      ),
      AIAssistantModel(
        id: 'ai_wellbeing',
        name: 'Maja',
        role: 'Podpora počutju',
        avatarAsset: 'assets/icons/ai_wellbeing.png',
        introText: 'Tukaj sem, kadar potrebuješ pogovor ali podporo 💜',
      ),
      AIAssistantModel(
        id: 'ai_baby',
        name: 'Zala',
        role: 'Dojenčkov svet',
        avatarAsset: 'assets/icons/ai_baby.png',
        introText: 'Pomagam pri dojenju, uvajanju hrane in rutini 🍼',
      ),
    ];
  }

  static const Map<String, Map<String, String>> _byAssistant = {
    'ai_nutrition': {
      'želez':
          'Odlični rastlinski viri železa so leča, čičerika, fižol, tofu, '
              'ovseni kosmiči in bučna semena. Absorpcijo močno izboljša '
              'vitamin C — dodaj papriko, agrume ali jagodičevje k obroku, '
              'kavo in pravi čaj pa raje zamakni stran od obrokov 🌿',
      'b12':
          'B12 je edino hranilo, ki ga na rastlinski prehrani NUJNO '
              'dodajaš: obogatena rastlinska mleka, kvasni kosmiči in — '
              'najzanesljiveje — prehransko dopolnilo. O odmerku v '
              'nosečnosti in med dojenjem se posvetuj z zdravnikom 💚',
      'kalcij':
          'Kalcij najdeš v tofuju (s kalcijevim koagulantom), obogatenih '
              'rastlinskih mlekih, tahiniju, brokoliju in ohrovtu. '
              'Zraven pomaga vitamin D 🥦',
      'beljakovin':
          'Stročnice, tofu, tempeh, seitan, kvinoja, oreščki in semena — '
              'če jih razporediš čez dan, rastlinska prehrana z lahkoto '
              'pokrije beljakovine tudi v nosečnosti 💪🌱',
      'omega':
          'Omega-3 dobiš iz mletih lanenih semen, chia semen in orehov. '
              'Za DHA (pomembna v nosečnosti in med dojenjem) razmisli o '
              'dodatku iz alg — posvetuj se z zdravnikom 🌊',
      'kosilo':
          'Kaj praviš na lečin curry s kokosovim mlekom ali tofu stir-fry '
              'z brokolijem? Oba najdeš med recepti — hitra, topla in polna '
              'železa 🍛 Odpri zavihek Recepti za več idej.',
      'zajtrk':
          'Ovsena kaša z jagodami in chia semeni, zeleni smoothie ali '
              'avokadov toast — vse tri najdeš med recepti. Obogateno '
              'rastlinsko mleko doda B12 in kalcij 🍓',
    },
    'ai_wellbeing': {
      'utrujen':
          'Utrujenost je v tem obdobju povsem normalna. Če se da, si '
              'privošči kratek počitek — tudi 15 minut šteje. Bodi nežna '
              'do sebe: ni ti treba zmoči vsega naenkrat 💜',
      'spanec':
          'Spanec je zdaj dragocen in razdrobljen. Pomaga mirna večerna '
              'rutina, manj zaslonov pred spanjem in počitek takrat, ko '
              'počiva otrok. In ne — ni razvajanje 🌙',
      'strah':
          'Strahovi in skrbi so del te poti in nisi edina, ki jih čuti. '
              'Pogovori se z nekom, ki mu zaupaš. Če te skrbi ne izpustijo, '
              'je pogovor s strokovnjakom znak moči, ne šibkosti 💚',
      'sama':
          'Slišim te. Materinstvo zna biti osamljeno, čeprav nikoli nisi '
              'zares sama ob otroku. Male povezave štejejo — sprehod, klic '
              'prijateljici, skupina mamic. Zaslužiš si podporo 💜',
    },
    'ai_baby': {
      'uvajan':
          'Z uvajanjem začnite okoli 6. meseca, ko otrok sedi s podporo '
              'in kaže zanimanje za hrano. Eno živilo naenkrat, brez '
              'hitenja. V aplikaciji imaš vodnik Uvajanje hrane s '
              'primernimi živili po starosti 🥄',
      'doji':
          'Dojenje je v prvih tednih pogosto — 8 do 12 podojev na dan je '
              'običajno. Vsak par mama-otrok najde svoj ritem. Ob dvomih '
              'so IBCLC svetovalke za dojenje zlata vredna podpora 🍼',
      'alerg':
          'Alergene (arašidi, soja, gluten, sezam) uvajaj posamezno, v '
              'majhnih količinah in opazuj 2–3 dni. Ob izpuščaju ali '
              'težavah z dihanjem takoj k pediatru. Vodnik v aplikaciji '
              'ima opombe pri vsakem alergenu ⚠️',
      'izbirčn':
          'Izbirčnost je normalna razvojna faza, ne tvoj neuspeh. Otroku '
              'živilo mirno ponudi tudi 10–15-krat, brez pritiska. Šteje '
              'pester teden, ne popoln dan 🧸',
    },
  };

  static const _fallbacks = [
    'To je dobro vprašanje 💚 Povej mi še kaj več, da ti lažje pomagam — '
        'ali pa poglej med recepte in vodnik uvajanja hrane v aplikaciji.',
    'Hvala, da si delila. Vsaka pot je svoja — kaj bi ti v tem trenutku '
        'najbolj pomagalo? 🌿',
    'Razumem te. Če iščeš konkretne ideje, poglej zavihek Recepti; za '
        'vprašanja o otroku pa vodnik Uvajanje hrane 💚',
  ];

  int _fallbackIndex = 0;

  @override
  Future<String> sendMessage(
    String assistantId,
    String message, {
    List<ChatMessage> history = const [],
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final lower = message.toLowerCase();

    // Safety net always wins.
    if (AISafety.isMedical(message)) return AISafety.response;

    final responses = _byAssistant[assistantId] ?? const {};
    for (final entry in responses.entries) {
      if (lower.contains(entry.key)) return entry.value;
    }

    final fallback = _fallbacks[_fallbackIndex % _fallbacks.length];
    _fallbackIndex++;
    return fallback;
  }
}
