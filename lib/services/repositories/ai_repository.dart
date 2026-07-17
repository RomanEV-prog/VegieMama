import '../../models/ai_assistant_model.dart';
import '../mock/mock_ai_service.dart';
import '../remote/ai_service.dart';

/// Chat backend behind the provider. Development runs on the mock;
/// switching to [RemoteAIService] is a one-line change here.
class AIRepository {
  final AIService _service = MockAIService();

  Future<List<AIAssistantModel>> getAssistants() => _service.getAssistants();
  Future<String> sendMessage(String assistantId, String message) =>
      _service.sendMessage(assistantId, message);
}
