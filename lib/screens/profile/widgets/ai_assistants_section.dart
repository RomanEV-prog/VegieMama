import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../providers/ai_chat_provider.dart';
import '../../../widgets/section_title.dart';

/// Entry points into AI chat, one tile per assistant.
class AIAssistantsSection extends StatelessWidget {
  const AIAssistantsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AIChatProvider>(
      builder: (context, provider, _) {
        if (provider.assistants.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'Tvoje pomočnice'),
            Card(
              margin: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
              child: Column(
                children: [
                  for (final assistant in provider.assistants)
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            AppColors.lavender.withValues(alpha: 0.4),
                        child: Text(
                          assistant.name.isNotEmpty ? assistant.name[0] : '?',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      title: Text(assistant.name),
                      subtitle: Text(
                        assistant.role,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.textSecondary),
                      ),
                      trailing: const Icon(Icons.chevron_right,
                          color: AppColors.textLight),
                      onTap: () {
                        provider.setActiveAssistant(assistant.id);
                        context.go('/ai');
                      },
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
