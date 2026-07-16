import '../../models/user_model.dart';
import '../mock/mock_user_service.dart';

class UserRepository {
  final MockUserService _service = MockUserService();

  Future<UserModel> getCurrentUser() => _service.getCurrentUser();
  Future<void> updateUser(UserModel user) => _service.updateUser(user);
}
