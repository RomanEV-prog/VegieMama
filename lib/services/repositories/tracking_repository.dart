import '../../models/tracking_data_model.dart';
import '../local/storage_service.dart';

/// Local-first tracking storage, one entry per day (key = yyyy-MM-dd).
class TrackingRepository {
  final StorageService _storage = StorageService.instance;

  static String dateKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  Future<TrackingDataModel> getTodayData() async {
    final now = DateTime.now();
    final stored = _storage.loadTracking(dateKey(now));
    if (stored != null) return TrackingDataModel.fromJson(stored);
    return TrackingDataModel(date: now);
  }

  /// Last 7 days, oldest first; days without entries come back empty.
  Future<List<TrackingDataModel>> getWeekData() async {
    final today = DateTime.now();
    return List.generate(7, (i) {
      final date = today.subtract(Duration(days: 6 - i));
      final stored = _storage.loadTracking(dateKey(date));
      return stored != null
          ? TrackingDataModel.fromJson(stored)
          : TrackingDataModel(date: date);
    });
  }

  Future<void> saveTrackingData(TrackingDataModel data) =>
      _storage.saveTracking(dateKey(data.date), data.toJson());
}
