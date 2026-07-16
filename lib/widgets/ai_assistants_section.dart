import 'package:flutter/material.dart';

class AIAssistantsSection extends StatelessWidget {
  const AIAssistantsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            Text('AI asistenti'),
          ],
        ),
      ),
    );
  }
} 