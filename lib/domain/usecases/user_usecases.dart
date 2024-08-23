import 'package:employee_attendance/domain/entities/user.dart';
import 'package:employee_attendance/domain/repositories/user_repository.dart';

class UserUseCases {
  final UserRepository _userRepository;

  UserUseCases(this._userRepository);

  Future<User?> createDemoUser() => _userRepository.createDemoUser();
  Future<User?> login(String email, String password) =>
      _userRepository.login(email, password);
  Future<void> logout() async {
    await _userRepository.logout();
  }

  Future<User?> fetchUserData(String userId) =>
      _userRepository.fetchUserData(userId);
  Future<void> updateUser(User user) => _userRepository.updateUser(user);
  Stream<User?> getUserStream(String userId) =>
      _userRepository.getUserStream(userId);

  Future<String?> getDeviceToken() => _userRepository.getDeviceToken();
}
