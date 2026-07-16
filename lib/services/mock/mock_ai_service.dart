import '../../models/ai_assistant_model.dart';

/// Mock AI data for development
class MockAIService {
  Future<List<AIAssistantModel>> getAssistants() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      AIAssistantModel(
        id: 'ai_nutrition',
        name: 'Lina',
        role: 'Prehranska svetovalka',
        avatarAsset: 'assets/icons/ai_nutrition.png',
        introText: 'Pomagam ti s prehranskimi vprašanji v rastlinski prehrani 🌿',
        lastConversationPreview: 'Železo lahko najdeš v leči, špinači...',
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

  Future<String> sendMessage(String assistantId, String message) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return 'To je odlično vprašanje! Tukaj imam nekaj nežnih nasvetov zate... 💚';
  }
}
