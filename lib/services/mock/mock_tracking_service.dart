import '../../models/tracking_data_model.dart';

/// Mock tracking data for development
class MockTrackingService {
  Future<TrackingDataModel> getTodayData() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return TrackingDataModel(
      date: DateTime.now(),
      waterIntake: 1250,
      waterGoal: 2000,
      sleepHours: 7.5,
      sleepGoal: 8,
      moodRating: 4,
      mealsLogged: 2,
      vitamins: ['B12', 'Železo', 'Vitamin D'],
      breastfeedingSessions: 0,
    );
  }

  Future<List<TrackingDataModel>> getWeekData() async {
    await Future.delayed(const Duration(milliseconds: 400));
    final today = DateTime.now();
    return List.generate(7, (i) {
      final date = today.subtract(Duration(days: 6 - i));
      return TrackingDataModel(
        date: date,
        waterIntake: 1000 + (i * 150),
        waterGoal: 2000,
        sleepHours: 6.0 + (i * 0.3),
        sleepGoal: 8,
        moodRating: 3 + (i % 3),
        mealsLogged: 2 + (i % 2),
        vitamins: ['B12'],
      );
    });
  }

  Future<void> saveTrackingData(TrackingDataModel data) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
