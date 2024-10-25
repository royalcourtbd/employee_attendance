import 'package:employee_attendance/domain/entities/employee_entity.dart';
import 'package:employee_attendance/domain/repositories/employee_repository.dart';

class CreateDemoUserUseCase {
  final EmployeeRepository _repository;
  CreateDemoUserUseCase(this._repository);
  Future<EmployeeEntity?> execute() => _repository.createDemoUser();
}
