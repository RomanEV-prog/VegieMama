import 'package:flutter/foundation.dart';
import '../models/tracking_data_model.dart';
import 'tracking_provider.dart';
import 'user_provider.dart';

/// Derived progress state for UI display
class UserProgressProvider extends ChangeNotifier {
  final TrackingProvider _trackingProvider;
  final UserProvider _userProvider;

  UserProgressProvider({
    required TrackingProvider trackingProvider,
    required UserProvider userProvider,
  })  : _trackingProvider = trackingProvider,
        _userProvider = userProvider {
    _trackingProvider.addListener(_update);
    _userProvider.addListener(_update);
  }

  void _update() => notifyListeners();

  TrackingDataModel? get _today => _trackingProvider.todayData;

  double get waterProgress => _today?.waterProgress ?? 0.0;
  double get sleepProgress => _today?.sleepProgress ?? 0.0;
  int get moodRating => _today?.moodRating ?? 3;
  int get mealsLogged => _today?.mealsLogged ?? 0;
  int get vitaminsCount => _today?.vitamins.length ?? 0;
  String get userName => _userProvider.user?.firstName ?? '';

  @override
  void dispose() {
    _trackingProvider.removeListener(_update);
    _userProvider.removeListener(_update);
    super.dispose();
  }
}
