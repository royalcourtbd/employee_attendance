import 'package:employee_attendance/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?> createDemoUser();
  Future<User?> login(String email, String password);
  Future<void> logout();
  Future<User?> fetchUserData(String userId);
  Future<void> updateUser(User user);
  Stream<User?> getUserStream(String userId);
  Future<String?> getDeviceToken();
}
