import 'package:flutter/material.dart';

class PremiumStatusCard extends StatelessWidget {
  const PremiumStatusCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber[100],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            Text('Premium status'),
          ],
        ),
      ),
    );
  }
} 