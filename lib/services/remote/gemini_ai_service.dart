import 'package:dio/dio.dart';
import '../../core/errors/app_exception.dart';
import '../../core/helpers/env_config.dart';
import '../../models/ai_assistant_model.dart';
import '../../models/chat_message_model.dart';
import '../ai_safety.dart';
import '../mock/mock_ai_service.dart';
import 'ai_service.dart';

/// Real AI backend on the Gemini API.
/// Follows the GreenHeart gemini-api recipes: the `gemini-flash-latest`
/// alias (fixed model names lose their free tier), maxOutputTokens
/// >= 2048 (thinking counts against the budget) and one retry on 503.
class GeminiAIService implements AIService {
  static const _model = 'gemini-flash-latest';
  static const _endpoint =
      'https://generativelanguage.googleapis.com/v1beta/models/$_model:generateContent';

  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 60),
  ));

  // The assistant catalogue stays local — only replies come from Gemini.
  final MockAIService _catalogue = MockAIService();

  static const _commonRules =
      'Piši navadno besedilo BREZ markdown oznak (brez **, *, #, alinej '
      'z zvezdicami) — aplikacija prikazuje golo besedilo. Sezname piši '
      'kot kratke stavke ali z vezaji. '
      'Odgovarjaj v jeziku zadnjega sporočila (privzeto v slovenščini). '
      'Bodi topla, pomirjujoča in konkretna; do ~120 besed; brez '
      'obsojanja in brez tekmovalnosti; zmerno uporabljaj emojije. '
      'NIKOLI ne postavljaš diagnoz, ne predpisuješ zdravil ali '
      'odmerkov. Ob zdravstvenih simptomih, skrbeh za zdravje ali '
      'duševni stiski prijazno usmeri k zdravniku, ginekologu oziroma '
      'pediatru, v nujnih primerih na 112. Ne izmišljuj si dejstev; '
      'kadar nisi prepričana, to povej.';

  static const _personas = {
    'ai_nutrition':
        'Ti si Lina, nežna prehranska svetovalka v aplikaciji VeggieMama. '
            'Specializirana si za rastlinsko (vegansko/vegetarijansko) '
            'prehrano v nosečnosti, po porodu, med dojenjem ter za '
            'dojenčke in malčke do 3 let. Poudarjaš ključna hranila: '
            'B12, železo, kalcij, jod, omega-3 (DHA iz alg), vitamin D, '
            'beljakovine in cink.',
    'ai_wellbeing':
        'Ti si Maja, sočutna podpora počutju v aplikaciji VeggieMama. '
            'Pomagaš nosečnicam in mamicam pri utrujenosti, skrbeh, '
            'spancu in čustvenih vzponih ter padcih. Poslušaš, '
            'normaliziraš občutke in predlagaš majhne, izvedljive korake.',
    'ai_baby':
        'Ti si Zala, prijazna svetovalka za dojenčkov svet v aplikaciji '
            'VeggieMama. Pomagaš pri dojenju, uvajanju goste hrane '
            '(od ~6. meseca), alergenih, rutini in izbirčnosti malčkov. '
            'Izbirčnost vedno predstaviš kot normalno razvojno fazo.',
  };

  @override
  Future<List<AIAssistantModel>> getAssistants() =>
      _catalogue.getAssistants();

  @override
  Future<String> sendMessage(
    String assistantId,
    String message, {
    List<ChatMessage> history = const [],
  }) async {
    // Deterministic safety net — medical questions never reach the model.
    if (AISafety.isMedical(message)) return AISafety.response;

    final persona = _personas[assistantId] ?? _personas['ai_nutrition']!;
    // Keep the context light: the last 12 turns are plenty for a chat.
    final recent = history.length > 12
        ? history.sublist(history.length - 12)
        : history;

    final body = {
      'system_instruction': {
        'parts': [
          {'text': '$persona\n\n$_commonRules'}
        ],
      },
      'contents': [
        for (final m in recent)
          {
            'role': m.isUser ? 'user' : 'model',
            'parts': [
              {'text': m.content}
            ],
          },
        {
          'role': 'user',
          'parts': [
            {'text': message}
          ],
        },
      ],
      'generationConfig': {
        // Thinking models spend part of this budget internally —
        // keep it comfortably high (gemini-api skill gotcha).
        'maxOutputTokens': 2048,
        'temperature': 0.7,
      },
    };

    final response = await _postWithRetry(body);
    final candidates = response['candidates'] as List<dynamic>?;
    if (candidates == null || candidates.isEmpty) {
      throw const NetworkException('AI ni vrnil odgovora.');
    }
    final candidate = candidates.first as Map<String, dynamic>;
    final parts =
        (candidate['content'] as Map<String, dynamic>?)?['parts'] as List?;
    final text = parts
            ?.map((p) => (p as Map<String, dynamic>)['text'] as String? ?? '')
            .join()
            .trim() ??
        '';
    if (text.isEmpty) {
      throw NetworkException(
          'AI ni vrnil besedila (${candidate['finishReason']}).');
    }
    return text;
  }

  Future<Map<String, dynamic>> _postWithRetry(
      Map<String, dynamic> body) async {
    for (var attempt = 0; ; attempt++) {
      try {
        final response = await _dio.post<Map<String, dynamic>>(
          '$_endpoint?key=${EnvConfig.geminiApiKey}',
          data: body,
        );
        return response.data ?? {};
      } on DioException catch (e) {
        // 503 is transient (gemini-api skill) — one gentle retry.
        if (e.response?.statusCode == 503 && attempt == 0) {
          await Future.delayed(const Duration(seconds: 3));
          continue;
        }
        throw NetworkException(
          'Povezava z AI ni uspela (${e.response?.statusCode ?? e.type.name}).',
          originalError: e,
        );
      }
    }
  }
}
