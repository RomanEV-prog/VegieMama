import 'package:flutter/material.dart';

class FavoriteRecipesSection extends StatelessWidget {
  const FavoriteRecipesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            Text('Najljubši recepti'),
          ],
        ),
      ),
    );
  }
} 