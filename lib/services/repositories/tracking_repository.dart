import '../../models/tracking_data_model.dart';
import '../mock/mock_tracking_service.dart';

class TrackingRepository {
  final MockTrackingService _service = MockTrackingService();

  Future<TrackingDataModel> getTodayData() => _service.getTodayData();
  Future<List<TrackingDataModel>> getWeekData() => _service.getWeekData();
  Future<void> saveTrackingData(TrackingDataModel data) =>
      _service.saveTrackingData(data);
}
