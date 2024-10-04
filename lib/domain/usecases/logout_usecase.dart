import 'package:employee_attendance/domain/repositories/employee_repository.dart';

class LogoutUseCase {
  final EmployeeRepository _employeeRepository;

  LogoutUseCase(this._employeeRepository);

  Future<void> execute() async {
    await _employeeRepository.logout();
  }
}
