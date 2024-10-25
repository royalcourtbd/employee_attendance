import 'package:employee_attendance/domain/entities/employee_entity.dart';
import 'package:employee_attendance/domain/repositories/employee_repository.dart';

class GetUserStreamUseCase {
  final EmployeeRepository _repository;
  GetUserStreamUseCase(this._repository);
  Stream<EmployeeEntity?> execute(String userId) =>
      _repository.getUserStream(userId);
}
