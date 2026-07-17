import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../providers/ai_chat_provider.dart';

/// Horizontal chips to switch between assistants — each keeps her own
/// conversation.
class AssistantPicker extends StatelessWidget {
  const AssistantPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AIChatProvider>();
    if (provider.assistants.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding,
        ),
        itemCount: provider.assistants.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final assistant = provider.assistants[index];
          final selected = assistant.id == provider.activeAssistantId;
          return ChoiceChip(
            avatar: CircleAvatar(
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
              child: Text(
                assistant.name[0],
                style: const TextStyle(fontSize: 12),
              ),
            ),
            label: Text('${assistant.name} · ${assistant.role}'),
            selected: selected,
            onSelected: (_) {
              HapticFeedback.selectionClick();
              context.read<AIChatProvider>().setActiveAssistant(assistant.id);
            },
          );
        },
      ),
    );
  }
}
