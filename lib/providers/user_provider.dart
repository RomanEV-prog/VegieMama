import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/local/preferences_service.dart';
import '../services/repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _repository = UserRepository();

  UserModel? _user;
  bool _isLoading = true;
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

  /// Creates the user at the end of onboarding and persists everything.
  Future<void> createUser(UserModel user) async {
    _user = user;
    _isLoading = false;
    notifyListeners();
    await _repository.saveUser(user);
    if (PreferencesService.instance.isInitialized) {
      await PreferencesService.instance
          .setOnboardingCompleted(user.onboardingCompleted);
    }
  }

  Future<void> updateUser(UserModel updatedUser) async {
    try {
      await _repository.saveUser(updatedUser);
      _user = updatedUser;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Removes the user (part of "delete my data").
  Future<void> reset() async {
    await _repository.deleteUser();
    _user = null;
    notifyListeners();
  }
}
