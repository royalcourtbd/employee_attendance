import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:fpdart/fpdart.dart';

abstract class EmployeeRepository {
  Future<Employee?> createDemoUser();
  Future<Either<String, Employee?>> login(String email, String password);
  Future<void> logout();
  Future<Employee?> fetchUserData(String userId);
  Future<void> updateUser(Employee user);
  Stream<Employee?> getUserStream(String userId);
  Stream<List<Employee>> getAllEmployees();
  Future<String?> getDeviceToken();
}
