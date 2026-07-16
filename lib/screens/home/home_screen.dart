import 'package:flutter/material.dart';
import '../../core/widgets/veggie_mama_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: VeggieMamaAppBar(title: 'Domov'),
      body: Center(child: Text('Domov – skoraj tu 🌿')),
    );
  }
}
