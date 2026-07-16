import 'package:flutter/foundation.dart';
import '../models/ai_assistant_model.dart';
import '../services/repositories/ai_repository.dart';

class AIChatProvider extends ChangeNotifier {
  final AIRepository _repository = AIRepository();

  List<AIAssistantModel> _assistants = [];
  String? _activeAssistantId;
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;
  bool _isSending = false;
  String? _error;

  List<AIAssistantModel> get assistants => _assistants;
  String? get activeAssistantId => _activeAssistantId;
  AIAssistantModel? get activeAssistant =>
      _assistants.where((a) => a.id == _activeAssistantId).firstOrNull;
  List<Map<String, String>> get messages => _messages;
  bool get isLoading => _isLoading;
  bool get isSending => _isSending;
  String? get error => _error;

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
    _messages.clear();
    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    if (_activeAssistantId == null) return;

    _messages.add({'role': 'user', 'content': text});
    _isSending = true;
    notifyListeners();

    try {
      final response =
          await _repository.sendMessage(_activeAssistantId!, text);
      _messages.add({'role': 'assistant', 'content': response});
    } catch (e) {
      _error = e.toString();
    } finally {
      _isSending = false;
      notifyListeners();
    }
  }
}
