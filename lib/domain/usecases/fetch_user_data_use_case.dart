import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:employee_attendance/domain/repositories/employee_repository.dart';

class FetchUserDataUseCase {
  final EmployeeRepository _repository;
  FetchUserDataUseCase(this._repository);
  Future<Employee?> execute(String userId) => _repository.fetchUserData(userId);
}
