/// Deterministic safety net for the AI chat — shared by the mock and
/// the real (Gemini) backend. Medical-sounding messages never reach
/// the model; the answer is always a gentle redirect to a doctor.
class AISafety {
  AISafety._();

  static const keywords = [
    'boli', 'bolečin', 'krvav', 'vročin', 'zdravil', 'tablet', 'izpuščaj',
    'bruha', 'driska', 'omedl', 'vrtoglav', 'krč', 'urgenc', 'antibiotik',
    'depresi', 'ne zmorem več', 'samomor',
  ];

  static const String response =
      'Hvala, da si mi zaupala. Pri zdravstvenih težavah ti jaz ne smem '
      'in ne morem svetovati — prosim, obrni se na svojega zdravnika, '
      'ginekologa ali pediatra, pri nujnih stvareh pa na 112. '
      'Tvoje zdravje je vedno na prvem mestu 💚';

  static bool isMedical(String message) {
    final lower = message.toLowerCase();
    return keywords.any(lower.contains);
  }
}
