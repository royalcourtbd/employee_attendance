import 'package:employee_attendance/domain/repositories/employee_repository.dart';

class GenerateNewEmployeeIdUseCase {
  final EmployeeRepository _repository;
  GenerateNewEmployeeIdUseCase(this._repository);

  Future<String> execute() async {
    final lastId = await _repository.getLastEmployeeId();
    if (lastId == null) {
      return 'EMP001';
    }
    final lastNumber = int.parse(lastId.substring(3));
    final newNumber = lastNumber + 1;
    return 'EMP${newNumber.toString().padLeft(3, '0')}';
  }
}
