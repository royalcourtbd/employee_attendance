import 'package:employee_attendance/data/models/employee_user_model.dart';
import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:fpdart/fpdart.dart';

abstract class EmployeeRepository {
  Future<Employee?> createDemoUser();
  Future<void> addEmployee(Employee employee);
  Future<String?> getLastEmployeeId();
  Future<Either<String, Employee?>> login(String email, String password);
  Future<void> logout();
  Future<Employee?> fetchUserData(String userId);
  Future<void> updateUser(Employee user);
  Stream<Employee?> getUserStream(String userId);
  Stream<List<EmployeeUserModel>> getAllEmployees();
  Future<void> changePassword(String newPassword);
  Future<String?> getDeviceToken();
}
