import 'package:employee_attendance/domain/entities/employee_entity.dart';
import 'package:employee_attendance/domain/repositories/employee_repository.dart';

class FetchUserDataUseCase {
  final EmployeeRepository _repository;
  FetchUserDataUseCase(this._repository);
  Future<EmployeeEntity?> execute(String userId) =>
      _repository.fetchUserData(userId);
}
