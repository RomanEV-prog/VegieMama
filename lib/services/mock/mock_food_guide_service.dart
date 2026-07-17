import '../../models/food_introduction_model.dart';

/// Catalogue of foods for gentle introduction on a plant-based diet.
/// Ages follow common guidance (WHO: gosta hrana od ~6. meseca);
/// the app always tells the user to confirm with their pediatrician.
class MockFoodGuideService {
  Future<List<FoodIntroductionModel>> getCatalogue() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return catalogue;
  }

  static const catalogue = [
    // ~6 mesecev — prve žličke
    FoodIntroductionModel(
      foodId: 'korenje',
      name: 'Korenje',
      emoji: '🥕',
      category: 'zelenjava',
      recommendedFromMonth: 6,
      note: 'Kuhano v pari in gladko pretlačeno — klasična prva žlička.',
    ),
    FoodIntroductionModel(
      foodId: 'bucka',
      name: 'Bučka',
      emoji: '🥒',
      category: 'zelenjava',
      recommendedFromMonth: 6,
      note: 'Blag okus, redko povzroča težave. Olupi in odstrani semena.',
    ),
    FoodIntroductionModel(
      foodId: 'sladki_krompir',
      name: 'Sladki krompir',
      emoji: '🍠',
      category: 'zelenjava',
      recommendedFromMonth: 6,
      note: 'Naravno sladek, bogat z beta karotenom.',
    ),
    FoodIntroductionModel(
      foodId: 'jabolko',
      name: 'Jabolko',
      emoji: '🍎',
      category: 'sadje',
      recommendedFromMonth: 6,
      note: 'Kuhano ali pečeno in pretlačeno; surovo šele z zobki.',
    ),
    FoodIntroductionModel(
      foodId: 'banana',
      name: 'Banana',
      emoji: '🍌',
      category: 'sadje',
      recommendedFromMonth: 6,
      note: 'Ni je treba kuhati — samo dobro zrelo pretlači.',
    ),
    FoodIntroductionModel(
      foodId: 'ovseni_kosmici',
      name: 'Ovseni kosmiči',
      emoji: '🌾',
      category: 'žita',
      recommendedFromMonth: 6,
      note: 'Fino mleti v kašo; dober vir železa za vegi dojenčke.',
    ),
    FoodIntroductionModel(
      foodId: 'proso',
      name: 'Proso',
      emoji: '🌾',
      category: 'žita',
      recommendedFromMonth: 6,
      note: 'Brez glutena, nežno za trebušček. Dobro splakni pred kuho.',
    ),
    // ~7–8 mesecev
    FoodIntroductionModel(
      foodId: 'rdeca_leca',
      name: 'Rdeča leča',
      emoji: '🍲',
      category: 'stročnice',
      recommendedFromMonth: 7,
      note: 'Ključen vir železa in beljakovin na rastlinski poti. '
          'Dobro kuhana in pretlačena.',
    ),
    FoodIntroductionModel(
      foodId: 'cicerika',
      name: 'Čičerika',
      emoji: '🥣',
      category: 'stročnice',
      recommendedFromMonth: 8,
      note: 'Kot gladek humus brez soli. Cink in beljakovine.',
    ),
    FoodIntroductionModel(
      foodId: 'tofu',
      name: 'Tofu',
      emoji: '🧊',
      category: 'stročnice',
      recommendedFromMonth: 8,
      note: 'Mehak tofu s kalcijem, narezan na paličice za prstke. '
          'Soja je alergen — uvajaj posamezno in opazuj.',
    ),
    FoodIntroductionModel(
      foodId: 'avokado',
      name: 'Avokado',
      emoji: '🥑',
      category: 'sadje',
      recommendedFromMonth: 6,
      note: 'Zdrave maščobe za razvoj možganov. Zrel in pretlačen.',
    ),
    FoodIntroductionModel(
      foodId: 'arasidovo_maslo',
      name: 'Arašidovo maslo',
      emoji: '🥜',
      category: 'oreščki in semena',
      recommendedFromMonth: 7,
      note: 'Alergen: tanek premaz gladkega masla, nikoli celi arašidi '
          '(nevarnost zadušitve). Zgodnje uvajanje lahko zmanjša tveganje '
          'alergije — posvetuj se s pediatrom.',
    ),
    FoodIntroductionModel(
      foodId: 'tahini',
      name: 'Tahini (sezamova pasta)',
      emoji: '🫙',
      category: 'oreščki in semena',
      recommendedFromMonth: 8,
      note: 'Odličen vir kalcija. Sezam je alergen — uvajaj posamezno.',
    ),
    FoodIntroductionModel(
      foodId: 'laneno_seme',
      name: 'Mleto laneno seme',
      emoji: '🌱',
      category: 'oreščki in semena',
      recommendedFromMonth: 8,
      note: 'Žlička v kašo za omega-3. Vedno mleto, sveže shranjeno.',
    ),
    // ~9–12 mesecev
    FoodIntroductionModel(
      foodId: 'polnozrnate_testenine',
      name: 'Polnozrnate testenine',
      emoji: '🍝',
      category: 'žita',
      recommendedFromMonth: 9,
      note: 'Mehko kuhane, narezane na koščke za prstke. Gluten je '
          'alergen — uvajaj posamezno.',
    ),
    FoodIntroductionModel(
      foodId: 'kvasni_kosmici',
      name: 'Kvasni kosmiči (obogateni)',
      emoji: '✨',
      category: 'dodatki',
      recommendedFromMonth: 9,
      note: 'Ščepec čez jed za B12 in »sirast« okus. Izberi obogatene.',
    ),
    FoodIntroductionModel(
      foodId: 'jagodicevje',
      name: 'Jagodičevje',
      emoji: '🫐',
      category: 'sadje',
      recommendedFromMonth: 9,
      note: 'Borovnice prepolovi, jagode nareži. Vitamin C pomaga '
          'pri absorpciji železa iz stročnic.',
    ),
    // 12+ mesecev
    FoodIntroductionModel(
      foodId: 'sojino_mleko',
      name: 'Obogateno sojino mleko',
      emoji: '🥛',
      category: 'dodatki',
      recommendedFromMonth: 12,
      note: 'Kot glavni napitek šele po 1. letu; izberi obogatenega '
          's kalcijem, B12 in D, brez sladkorja.',
    ),
  ];
}
