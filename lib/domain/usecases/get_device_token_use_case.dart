import 'package:employee_attendance/domain/repositories/employee_repository.dart';

class GetDeviceTokenUseCase {
  final EmployeeRepository _repository;
  GetDeviceTokenUseCase(this._repository);
  Future<String?> execute() => _repository.getDeviceToken();
}
