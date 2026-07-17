import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/helpers/l10n_ext.dart';
import '../../core/widgets/loading_state.dart';
import '../../core/widgets/veggie_mama_app_bar.dart';
import '../../providers/ai_chat_provider.dart';
import 'widgets/assistant_picker.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/suggested_prompts.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({super.key});

  @override
  State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _send() {
    final text = _inputController.text;
    if (text.trim().isEmpty) return;
    _inputController.clear();
    context.read<AIChatProvider>().sendMessage(text);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AIChatProvider>();
    _scrollToBottom();

    return Scaffold(
      appBar: VeggieMamaAppBar(title: context.l10n.titleAI),
      body: Builder(
        builder: (context) {
          if (provider.isLoading && provider.assistants.isEmpty) {
            return const LoadingState();
          }

          return Column(
            children: [
              const SizedBox(height: AppSpacing.sm),
              const AssistantPicker(),
              // Disclaimer — always visible, gently worded.
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline,
                        size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        context.l10n.aiDisclaimer,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: provider.messages.isEmpty && !provider.isSending
                    ? const SuggestedPrompts()
                    : ListView(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(
                          AppSpacing.screenPadding,
                        ),
                        children: [
                          for (final message in provider.messages)
                            ChatBubble(message: message),
                          if (provider.isSending) const TypingIndicator(),
                        ],
                      ),
              ),

              // Gentle error + retry
              if (provider.failedMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenPadding,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sporočilo ni prišlo skozi. Brez skrbi 💚',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                            if (provider.error != null)
                              // Tiny technical cause — release builds are
                              // otherwise blind (gemini-api skill gotcha).
                              Text(
                                provider.error!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: 10,
                                      color: AppColors.textLight,
                                    ),
                              ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            context.read<AIChatProvider>().retryLast(),
                        child: Text(context.l10n.commonRetry),
                      ),
                    ],
                  ),
                ),

              // Input
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.screenPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _inputController,
                          textInputAction: TextInputAction.send,
                          textCapitalization: TextCapitalization.sentences,
                          onSubmitted: (_) => _send(),
                          decoration: InputDecoration(
                            hintText: context.l10n.aiInputHint,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppRadius.xl),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                              vertical: AppSpacing.md,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      IconButton.filled(
                        onPressed: provider.isSending ? null : _send,
                        icon: const Icon(Icons.arrow_upward),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
