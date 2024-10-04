import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:employee_attendance/domain/repositories/employee_repository.dart';
import 'package:fpdart/fpdart.dart';

class EmployeeUseCases {
  final EmployeeRepository _userRepository;

  EmployeeUseCases(this._userRepository);

  Future<Employee?> createDemoUser() => _userRepository.createDemoUser();
  Future<Either<String, Employee?>> login(String email, String password) =>
      _userRepository.login(email, password);
  Future<void> logout() async {
    await _userRepository.logout();
  }

  Future<Employee?> fetchUserData(String userId) =>
      _userRepository.fetchUserData(userId);
  Future<void> updateUser(Employee user) => _userRepository.updateUser(user);
  Stream<Employee?> getUserStream(String userId) =>
      _userRepository.getUserStream(userId);
  Stream<List<Employee>> getAllEmployees() {
    return _userRepository.getAllEmployees();
  }

  Future<String?> getDeviceToken() => _userRepository.getDeviceToken();
}
