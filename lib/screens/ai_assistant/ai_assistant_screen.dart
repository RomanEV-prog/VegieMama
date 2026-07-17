import 'package:flutter/material.dart';
import '../../core/helpers/l10n_ext.dart';
import '../../core/widgets/veggie_mama_app_bar.dart';

class AIAssistantScreen extends StatelessWidget {
  const AIAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VeggieMamaAppBar(title: context.l10n.titleAI),
      body: const Center(child: Text('AI Pomočnik – skoraj tu 🌿')),
    );
  }
}
