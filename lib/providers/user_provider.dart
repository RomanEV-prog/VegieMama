import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _repository = UserRepository();

  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _user != null;
  bool get onboardingCompleted => _user?.onboardingCompleted ?? false;
  UserType? get userType => _user?.userType;

  Future<void> loadUser() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _user = await _repository.getCurrentUser();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUser(UserModel updatedUser) async {
    try {
      await _repository.updateUser(updatedUser);
      _user = updatedUser;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  void completeOnboarding() {
    if (_user != null) {
      _user = _user!.copyWith(onboardingCompleted: true);
      notifyListeners();
    }
  }
}
