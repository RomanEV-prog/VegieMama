import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../providers/ai_chat_provider.dart';

/// Gentle conversation starters shown while the chat is empty.
class SuggestedPrompts extends StatelessWidget {
  const SuggestedPrompts({super.key});

  static const _byAssistant = {
    'ai_nutrition': [
      'Kje dobim dovolj železa?',
      'Kaj moram vedeti o B12?',
      'Ideja za hitro kosilo?',
    ],
    'ai_wellbeing': [
      'Danes sem zelo utrujena',
      'Kako do boljšega spanca?',
      'Počutim se sama',
    ],
    'ai_baby': [
      'Kako začnem z uvajanjem hrane?',
      'Koliko podojev je normalno?',
      'Kako uvajam alergene?',
    ],
  };

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AIChatProvider>();
    final assistant = provider.activeAssistant;
    final prompts = _byAssistant[assistant?.id] ?? const <String>[];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (assistant != null) ...[
          Text(assistant.name,
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.xs),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
            ),
            child: Text(
              assistant.introText,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          alignment: WrapAlignment.center,
          children: [
            for (final prompt in prompts)
              ActionChip(
                label: Text(prompt),
                onPressed: () =>
                    context.read<AIChatProvider>().sendMessage(prompt),
              ),
          ],
        ),
      ],
    );
  }
}
