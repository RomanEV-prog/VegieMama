import '../../core/helpers/env_config.dart';
import '../../models/ai_assistant_model.dart';
import '../../models/chat_message_model.dart';
import '../mock/mock_ai_service.dart';
import '../remote/ai_service.dart';
import '../remote/gemini_ai_service.dart';

/// Chat backend behind the provider: the real Gemini model when an
/// API key is bundled (.env), otherwise the mock.
class AIRepository {
  final AIService _service =
      EnvConfig.hasGemini ? GeminiAIService() : MockAIService();

  Future<List<AIAssistantModel>> getAssistants() => _service.getAssistants();

  Future<String> sendMessage(
    String assistantId,
    String message, {
    List<ChatMessage> history = const [],
  }) =>
      _service.sendMessage(assistantId, message, history: history);
}
