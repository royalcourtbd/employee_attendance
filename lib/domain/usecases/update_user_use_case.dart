import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:employee_attendance/domain/repositories/employee_repository.dart';

class UpdateUserUseCase {
  final EmployeeRepository _repository;
  UpdateUserUseCase(this._repository);
  Future<void> execute(Employee user) => _repository.updateUser(user);
}
