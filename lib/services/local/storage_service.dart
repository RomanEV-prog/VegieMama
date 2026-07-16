import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

/// Wrapper around Hive for structured local storage.
/// Initialize once in main() via [init]; widget tests use
/// `init(inMemory: true)` (real Hive I/O hangs in the FakeAsync zone).
class StorageService {
  StorageService._();
  static final StorageService instance = StorageService._();

  static const String _userBox = 'user_box';
  static const String _trackingBox = 'tracking_box';
  static const String _appBox = 'app_box';

  bool _initialized = false;
  bool get isInitialized => _initialized;

  /// In-memory mode for widget tests: real Hive I/O never completes
  /// inside the FakeAsync test zone, so tests store into plain maps.
  bool _inMemory = false;
  final Map<String, Map<String, String>> _mem = {};

  Future<void> init({bool inMemory = false}) async {
    if (_initialized) return;
    _inMemory = inMemory;
    if (!inMemory) {
      await Hive.initFlutter();
      await Hive.openBox(_userBox);
      await Hive.openBox(_trackingBox);
      await Hive.openBox(_appBox);
    }
    _initialized = true;
  }

  // Generic save/load
  Future<void> save(
      String boxName, String key, Map<String, dynamic> data) async {
    if (_inMemory) {
      _mem.putIfAbsent(boxName, () => {})[key] = jsonEncode(data);
      return;
    }
    final box = Hive.box(boxName);
    await box.put(key, jsonEncode(data));
  }

  String? _rawGet(String boxName, String key) {
    if (_inMemory) return _mem[boxName]?[key];
    return Hive.box(boxName).get(key) as String?;
  }

  Map<String, dynamic>? load(String boxName, String key) {
    final raw = _rawGet(boxName, key);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<void> delete(String boxName, String key) async {
    if (_inMemory) {
      _mem[boxName]?.remove(key);
      return;
    }
    final box = Hive.box(boxName);
    await box.delete(key);
  }

  // User-specific
  Future<void> saveUser(Map<String, dynamic> data) =>
      save(_userBox, 'current_user', data);
  Map<String, dynamic>? loadUser() => load(_userBox, 'current_user');
  Future<void> deleteUser() => delete(_userBox, 'current_user');

  // Tracking-specific (key = yyyy-MM-dd)
  Future<void> saveTracking(String dateKey, Map<String, dynamic> data) =>
      save(_trackingBox, dateKey, data);
  Map<String, dynamic>? loadTracking(String dateKey) =>
      load(_trackingBox, dateKey);

  // Favorite recipe ids
  Future<void> saveFavoriteIds(List<String> ids) async {
    if (_inMemory) {
      _mem.putIfAbsent(_appBox, () => {})['favorite_ids'] = jsonEncode(ids);
      return;
    }
    final box = Hive.box(_appBox);
    await box.put('favorite_ids', jsonEncode(ids));
  }

  List<String>? loadFavoriteIds() {
    final raw = _rawGet(_appBox, 'favorite_ids');
    if (raw == null) return null;
    return (jsonDecode(raw) as List<dynamic>).map((e) => e as String).toList();
  }

  /// Wipes every stored value — used by "delete my data" in settings.
  Future<void> clearAll() async {
    if (_inMemory) {
      _mem.clear();
      return;
    }
    await Hive.box(_userBox).clear();
    await Hive.box(_trackingBox).clear();
    await Hive.box(_appBox).clear();
  }
}
