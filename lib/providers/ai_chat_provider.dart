import 'package:flutter/foundation.dart';
import '../models/ai_assistant_model.dart';
import '../models/chat_message_model.dart';
import '../services/repositories/ai_repository.dart';

class AIChatProvider extends ChangeNotifier {
  final AIRepository _repository = AIRepository();

  List<AIAssistantModel> _assistants = [];
  String? _activeAssistantId;

  /// One conversation per assistant — switching keeps context.
  final Map<String, List<ChatMessage>> _conversations = {};

  bool _isLoading = false;
  bool _isSending = false;
  String? _error;
  String? _failedMessage;

  List<AIAssistantModel> get assistants => _assistants;
  String? get activeAssistantId => _activeAssistantId;
  AIAssistantModel? get activeAssistant =>
      _assistants.where((a) => a.id == _activeAssistantId).firstOrNull;
  List<ChatMessage> get messages =>
      _conversations[_activeAssistantId] ?? const [];
  bool get isLoading => _isLoading;
  bool get isSending => _isSending;
  String? get error => _error;

  /// The message whose delivery failed — offered for a gentle retry.
  String? get failedMessage => _failedMessage;

  Future<void> loadAssistants() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _assistants = await _repository.getAssistants();
      if (_assistants.isNotEmpty && _activeAssistantId == null) {
        _activeAssistantId = _assistants.first.id;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setActiveAssistant(String id) {
    _activeAssistantId = id;
    _error = null;
    _failedMessage = null;
    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    final assistantId = _activeAssistantId;
    final trimmed = text.trim();
    if (assistantId == null || trimmed.isEmpty || _isSending) return;

    final history =
        List<ChatMessage>.of(_conversations[assistantId] ?? const []);
    _conversations.putIfAbsent(assistantId, () => []).add(ChatMessage(
          role: ChatRole.user,
          content: trimmed,
          sentAt: DateTime.now(),
        ));
    _isSending = true;
    _error = null;
    _failedMessage = null;
    notifyListeners();

    try {
      final reply = await _repository.sendMessage(assistantId, trimmed,
          history: history);
      _conversations[assistantId]!.add(ChatMessage(
        role: ChatRole.assistant,
        content: reply,
        sentAt: DateTime.now(),
      ));
    } catch (e) {
      _error = e.toString();
      _failedMessage = trimmed;
      // Remove the unanswered user message; retry re-sends it.
      final conversation = _conversations[assistantId]!;
      if (conversation.isNotEmpty && conversation.last.isUser) {
        conversation.removeLast();
      }
    } finally {
      _isSending = false;
      notifyListeners();
    }
  }

  Future<void> retryLast() async {
    final failed = _failedMessage;
    if (failed == null) return;
    _failedMessage = null;
    await sendMessage(failed);
  }
}
