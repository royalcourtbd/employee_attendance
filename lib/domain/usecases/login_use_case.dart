import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:employee_attendance/domain/repositories/employee_repository.dart';
import 'package:fpdart/fpdart.dart';

class LoginUseCase {
  final EmployeeRepository _repository;
  LoginUseCase(this._repository);
  Future<Either<String, Employee?>> execute(String email, String password) =>
      _repository.login(email, password);
}
