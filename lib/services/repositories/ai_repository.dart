import '../../models/ai_assistant_model.dart';
import '../mock/mock_ai_service.dart';

class AIRepository {
  final MockAIService _service = MockAIService();

  Future<List<AIAssistantModel>> getAssistants() => _service.getAssistants();
  Future<String> sendMessage(String assistantId, String message) =>
      _service.sendMessage(assistantId, message);
}
