import 'package:flutter/material.dart';
import '../../core/widgets/veggie_mama_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: VeggieMamaAppBar(title: 'Nastavitve', showBack: true),
      body: Center(child: Text('Nastavitve – skoraj tu 🌿')),
    );
  }
}
