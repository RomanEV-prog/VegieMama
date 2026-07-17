import '../../models/ai_assistant_model.dart';
import '../../models/chat_message_model.dart';

/// Contract for the AI chat backend. [GeminiAIService] talks to the
/// real model; [MockAIService] covers development and tests —
/// swapping them is a one-line change in [AIRepository],
/// with no UI or provider changes.
abstract class AIService {
  Future<List<AIAssistantModel>> getAssistants();

  Future<String> sendMessage(
    String assistantId,
    String message, {
    List<ChatMessage> history,
  });
}
