import '../../models/ai_assistant_model.dart';

/// Contract for the AI chat backend. [MockAIService] implements it for
/// development; [RemoteAIService] will implement it against the real
/// backend — swapping them is a one-line change in [AIRepository],
/// with no UI or provider changes.
abstract class AIService {
  Future<List<AIAssistantModel>> getAssistants();

  Future<String> sendMessage(String assistantId, String message);
}
