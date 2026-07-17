import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:veggiemama/l10n/app_localizations.dart';
import 'package:veggiemama/providers/ai_chat_provider.dart';
import 'package:veggiemama/screens/ai_assistant/ai_assistant_screen.dart';
import 'package:veggiemama/screens/ai_assistant/widgets/chat_bubble.dart';
import 'helpers/test_env.dart';

Widget _buildChat() {
  return ChangeNotifierProvider(
    create: (_) => AIChatProvider()..loadAssistants(),
    child: const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('sl'),
      home: AIAssistantScreen(),
    ),
  );
}

void main() {
  setUp(() async {
    await initTestEnv();
  });

  group('AIChatProvider', () {
    test('keyword answer and per-assistant conversations', () async {
      final provider = AIChatProvider();
      await provider.loadAssistants();
      expect(provider.activeAssistantId, 'ai_nutrition');

      await provider.sendMessage('Kje dobim dovolj železa?');
      expect(provider.messages.length, 2);
      expect(provider.messages.last.content, contains('leča'));

      // Switching keeps each conversation separate.
      provider.setActiveAssistant('ai_baby');
      expect(provider.messages, isEmpty);
      provider.setActiveAssistant('ai_nutrition');
      expect(provider.messages.length, 2);
    });

    test('medical questions always redirect to a doctor', () async {
      final provider = AIChatProvider();
      await provider.loadAssistants();

      await provider.sendMessage('Zelo me boli trebuh, kaj naj vzamem?');
      expect(provider.messages.last.content, contains('zdravnika'));
      expect(provider.messages.last.content.toLowerCase(),
          isNot(contains('priporočam ti tableto')));
    });
  });

  testWidgets('chat screen: disclaimer, suggested prompt sends and answers',
      (tester) async {
    await tester.pumpWidget(_buildChat());
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();

    // Disclaimer and suggested prompts are visible on the empty chat.
    expect(find.textContaining('ne nadomeščajo zdravnika'), findsOneWidget);
    expect(find.text('Kje dobim dovolj železa?'), findsOneWidget);

    await tester.tap(find.text('Kje dobim dovolj železa?'));
    await tester.pump(const Duration(milliseconds: 100));
    // Typing indicator while the mock "thinks".
    expect(find.byType(TypingIndicator), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 900));
    await tester.pump();
    expect(find.textContaining('leča'), findsOneWidget);
  });
}
