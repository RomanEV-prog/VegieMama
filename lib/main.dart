import 'package:flutter/material.dart';
import 'app.dart';
import 'services/local/preferences_service.dart';
import 'services/local/storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.instance.init();
  await PreferencesService.instance.init();
  runApp(const VeggieMamaApp());
}
