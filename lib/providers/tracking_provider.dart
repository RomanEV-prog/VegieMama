import 'package:flutter/foundation.dart';
import '../models/tracking_data_model.dart';
import '../services/repositories/tracking_repository.dart';

class TrackingProvider extends ChangeNotifier {
  final TrackingRepository _repository = TrackingRepository();

  TrackingDataModel? _todayData;
  List<TrackingDataModel> _weekData = [];
  bool _isLoading = false;
  String? _error;

  TrackingDataModel? get todayData => _todayData;
  List<TrackingDataModel> get weekData => _weekData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadTodayData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _todayData = await _repository.getTodayData();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadWeekData() async {
    try {
      _weekData = await _repository.getWeekData();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Applies a change to today's data, notifies the UI immediately and
  /// persists in the background. Persistence failures are kept quiet for
  /// the user (data stays in memory) but recorded in [error].
  void _mutate(TrackingDataModel Function(TrackingDataModel) change) {
    final today = _todayData;
    if (today == null) return;

    _todayData = change(today);
    notifyListeners();

    _repository.saveTrackingData(_todayData!).catchError((Object e) {
      _error = e.toString();
    });
  }

  void addWaterIntake(int ml) =>
      _mutate((t) => t.copyWith(waterIntake: t.waterIntake + ml));

  void setMood(int rating) => _mutate((t) => t.copyWith(moodRating: rating));

  void setSleep(double hours) => _mutate((t) => t.copyWith(sleepHours: hours));

  void logMeal() => _mutate((t) => t.copyWith(mealsLogged: t.mealsLogged + 1));

  void toggleVitamin(String vitamin) => _mutate((t) {
        final vitamins = List<String>.from(t.vitamins);
        if (vitamins.contains(vitamin)) {
          vitamins.remove(vitamin);
        } else {
          vitamins.add(vitamin);
        }
        return t.copyWith(vitamins: vitamins);
      });

  void logBreastfeeding() => _mutate(
      (t) => t.copyWith(breastfeedingSessions: t.breastfeedingSessions + 1));
}
