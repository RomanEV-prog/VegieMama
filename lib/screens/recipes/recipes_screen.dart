import 'package:flutter/material.dart';
import '../../core/widgets/veggie_mama_app_bar.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: VeggieMamaAppBar(title: 'Recepti'),
      body: Center(child: Text('Recepti – skoraj tu 🌿')),
    );
  }
}
