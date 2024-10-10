// lib/domain/usecases/change_password_use_case.dart

import 'package:employee_attendance/domain/repositories/employee_repository.dart';

class ChangePasswordUseCase {
  final EmployeeRepository _repository;

  ChangePasswordUseCase(this._repository);

  Future<void> execute(String newPassword) =>
      _repository.changePassword(newPassword);
}
