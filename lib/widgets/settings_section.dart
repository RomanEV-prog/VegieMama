import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            Text('Nastavitve in podpora'),
          ],
        ),
      ),
    );
  }
} 