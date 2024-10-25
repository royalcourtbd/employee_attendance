import 'package:employee_attendance/data/models/employee_user_model.dart';
import 'package:employee_attendance/domain/entities/employee_entity.dart';

abstract class EmployeeRepository {
  Future<EmployeeEntity?> createDemoUser();
  Future<void> addEmployee(EmployeeEntity employee);
  Future<String?> getLastEmployeeId();
  Future<EmployeeEntity?> fetchUserData(String userId);
  Future<void> updateUser(EmployeeEntity user);
  Stream<EmployeeEntity?> getUserStream(String userId);
  Stream<List<EmployeeUserModel>> getAllEmployees();
  Future<String?> getDeviceToken();
}
