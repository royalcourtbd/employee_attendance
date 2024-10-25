// lib/domain/usecases/change_password_use_case.dart

import 'package:employee_attendance/domain/repositories/employee/auth_repository.dart';

class ChangePasswordUseCase {
  final AuthRepository _repository;

  ChangePasswordUseCase(this._repository);

  Future<void> execute(String newPassword) =>
      _repository.changePassword(newPassword);
}
