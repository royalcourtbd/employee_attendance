import 'package:employee_attendance/data/models/employee_user_model.dart';
import 'package:employee_attendance/domain/entities/employee.dart';

abstract class EmployeeRepository {
  Future<Employee?> createDemoUser();
  Future<void> addEmployee(Employee employee);
  Future<String?> getLastEmployeeId();
  Future<Employee?> fetchUserData(String userId);
  Future<void> updateUser(Employee user);
  Stream<Employee?> getUserStream(String userId);
  Stream<List<EmployeeUserModel>> getAllEmployees();
  Future<String?> getDeviceToken();
}
