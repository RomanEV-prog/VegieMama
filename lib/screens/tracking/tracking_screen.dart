import 'package:flutter/material.dart';
import '../../core/widgets/veggie_mama_app_bar.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: VeggieMamaAppBar(title: 'Sledenje'),
      body: Center(child: Text('Sledenje – skoraj tu 🌿')),
    );
  }
}
