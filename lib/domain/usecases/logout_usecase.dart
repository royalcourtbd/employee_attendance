import 'package:employee_attendance/domain/repositories/employee/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _employeeRepository;

  LogoutUseCase(this._employeeRepository);

  Future<void> execute() async => await _employeeRepository.logout();
}
