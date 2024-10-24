import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:employee_attendance/domain/repositories/employee/auth_repository.dart';

import 'package:fpdart/fpdart.dart';

class LoginUseCase {
  final AuthRepository _repository;
  LoginUseCase(this._repository);
  Future<Either<String, Employee?>> execute(
      String email, String password) async {
    final result = await _repository.login(email, password);
    return result;
  }
}
