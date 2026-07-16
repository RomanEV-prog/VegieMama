import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

/// Wrapper around Hive for structured local storage
class StorageService {
  static const String _userBox = 'user_box';
  static const String _trackingBox = 'tracking_box';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_userBox);
    await Hive.openBox(_trackingBox);
  }

  // Generic save/load
  Future<void> save(String boxName, String key, Map<String, dynamic> data) async {
    final box = Hive.box(boxName);
    await box.put(key, jsonEncode(data));
  }

  Map<String, dynamic>? load(String boxName, String key) {
    final box = Hive.box(boxName);
    final raw = box.get(key);
    if (raw == null) return null;
    return jsonDecode(raw as String) as Map<String, dynamic>;
  }

  Future<void> delete(String boxName, String key) async {
    final box = Hive.box(boxName);
    await box.delete(key);
  }

  // User-specific
  Future<void> saveUser(Map<String, dynamic> data) =>
      save(_userBox, 'current_user', data);
  Map<String, dynamic>? loadUser() => load(_userBox, 'current_user');

  // Tracking-specific
  Future<void> saveTracking(String dateKey, Map<String, dynamic> data) =>
      save(_trackingBox, dateKey, data);
  Map<String, dynamic>? loadTracking(String dateKey) =>
      load(_trackingBox, dateKey);
}
