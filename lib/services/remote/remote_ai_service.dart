import '../../core/errors/app_exception.dart';
import '../../models/ai_assistant_model.dart';
import '../../models/chat_message_model.dart';
import 'ai_service.dart';
import 'api_client.dart';

/// Real-backend implementation of [AIService]. Not wired in yet —
/// [AIRepository] still uses the mock. Once the backend exists, fill
/// in the endpoints and swap the instance in the repository.
class RemoteAIService implements AIService {
  final ApiClient _client = ApiClient.instance;

  @override
  Future<List<AIAssistantModel>> getAssistants() async {
    if (ApiClient.baseUrl.isEmpty) {
      throw const NetworkException('AI backend ni konfiguriran.');
    }
    final response = await _client.dio.get<List<dynamic>>('/assistants');
    return (response.data ?? [])
        .map((e) => AIAssistantModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<String> sendMessage(
    String assistantId,
    String message, {
    List<ChatMessage> history = const [],
  }) async {
    if (ApiClient.baseUrl.isEmpty) {
      throw const NetworkException('AI backend ni konfiguriran.');
    }
    final response = await _client.dio.post<Map<String, dynamic>>(
      '/assistants/$assistantId/messages',
      data: {'message': message},
    );
    return response.data?['reply'] as String? ?? '';
  }
}
