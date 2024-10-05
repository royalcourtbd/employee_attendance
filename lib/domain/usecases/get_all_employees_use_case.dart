import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:employee_attendance/domain/repositories/employee_repository.dart';

class GetAllEmployeesUseCase {
  final EmployeeRepository _repository;
  GetAllEmployeesUseCase(this._repository);
  Stream<List<Employee>> execute() => _repository.getAllEmployees();
}
