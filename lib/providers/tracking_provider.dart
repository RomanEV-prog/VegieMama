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

  void addWaterIntake(int ml) {
    if (_todayData != null) {
      _todayData = _todayData!.copyWith(
        waterIntake: _todayData!.waterIntake + ml,
      );
      notifyListeners();
    }
  }

  void setMood(int rating) {
    if (_todayData != null) {
      _todayData = _todayData!.copyWith(moodRating: rating);
      notifyListeners();
    }
  }

  void setSleep(double hours) {
    if (_todayData != null) {
      _todayData = _todayData!.copyWith(sleepHours: hours);
      notifyListeners();
    }
  }

  void logMeal() {
    if (_todayData != null) {
      _todayData = _todayData!.copyWith(
        mealsLogged: _todayData!.mealsLogged + 1,
      );
      notifyListeners();
    }
  }

  void addVitamin(String vitamin) {
    if (_todayData != null) {
      final vitamins = List<String>.from(_todayData!.vitamins)..add(vitamin);
      _todayData = _todayData!.copyWith(vitamins: vitamins);
      notifyListeners();
    }
  }

  void logBreastfeeding() {
    if (_todayData != null) {
      _todayData = _todayData!.copyWith(
        breastfeedingSessions: _todayData!.breastfeedingSessions + 1,
      );
      notifyListeners();
    }
  }
}
