import 'package:employee_attendance/domain/entities/employee_entity.dart';
import 'package:employee_attendance/domain/repositories/employee_repository.dart';

class AddEmployeeUseCase {
  final EmployeeRepository _repository;
  AddEmployeeUseCase(this._repository);
  Future<void> execute(EmployeeEntity employee) =>
      _repository.addEmployee(employee);
}
