import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:employee_attendance/domain/repositories/employee_repository.dart';

class AddEmployeeUseCase {
  final EmployeeRepository _repository;
  AddEmployeeUseCase(this._repository);
  Future<void> execute(Employee employee) => _repository.addEmployee(employee);
}
