import 'package:flutter/material.dart';
import '../../core/widgets/veggie_mama_app_bar.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String recipeId;

  const RecipeDetailScreen({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VeggieMamaAppBar(title: 'Recept', showBack: true),
      body: Center(child: Text('Recept $recipeId – skoraj tu 🌿')),
    );
  }
}
