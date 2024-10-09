import 'package:employee_attendance/data/models/employee_user_model.dart';
import 'package:employee_attendance/domain/repositories/employee_repository.dart';

class GetAllEmployeesUseCase {
  final EmployeeRepository _repository;
  GetAllEmployeesUseCase(this._repository);
  Stream<List<EmployeeUserModel>> execute() =>
      _repository.getAllEmployees().map(
            (employees) => employees
                .map((employee) => EmployeeUserModel.fromUser(employee))
                .toList(),
          );
}
