import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:employee_attendance/domain/repositories/employee_repository.dart';

class CreateDemoUserUseCase {
  final EmployeeRepository _repository;
  CreateDemoUserUseCase(this._repository);
  Future<Employee?> execute() => _repository.createDemoUser();
}
