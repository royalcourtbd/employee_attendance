import 'package:employee_attendance/domain/entities/employee_entity.dart';
import 'package:employee_attendance/domain/repositories/employee_repository.dart';

class UpdateUserUseCase {
  final EmployeeRepository _repository;
  UpdateUserUseCase(this._repository);
  Future<void> execute(EmployeeEntity user) => _repository.updateUser(user);
}
