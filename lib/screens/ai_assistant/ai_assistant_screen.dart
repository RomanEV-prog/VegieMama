import 'package:flutter/material.dart';
import '../../core/widgets/veggie_mama_app_bar.dart';

class AIAssistantScreen extends StatelessWidget {
  const AIAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: VeggieMamaAppBar(title: 'AI Pomočnik'),
      body: Center(child: Text('AI Pomočnik – skoraj tu 🌿')),
    );
  }
}
