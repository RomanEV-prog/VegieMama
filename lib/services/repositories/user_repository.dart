import '../../models/user_model.dart';
import '../local/storage_service.dart';

/// Local-first user storage. The user is created in onboarding and
/// lives in Hive; there is no remote backend yet.
class UserRepository {
  final StorageService _storage = StorageService.instance;

  Future<UserModel?> getCurrentUser() async {
    final data = _storage.loadUser();
    if (data == null) return null;
    return UserModel.fromJson(data);
  }

  Future<void> saveUser(UserModel user) => _storage.saveUser(user.toJson());

  Future<void> deleteUser() => _storage.deleteUser();
}
