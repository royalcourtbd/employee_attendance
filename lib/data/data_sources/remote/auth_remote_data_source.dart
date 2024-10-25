import 'package:employee_attendance/data/services/backend_as_a_service.dart';
import 'package:employee_attendance/domain/entities/employee_entity.dart';
import 'package:fpdart/fpdart.dart';

class AuthRemoteDataSource {
  final BackendAsAService _backendAsAService;

  AuthRemoteDataSource(this._backendAsAService);

  Future<Either<String, EmployeeEntity?>> login(
      String email, String password) async {
    return await _backendAsAService.signIn(email, password);
  }

  Future<void> changePassword(String newPassword) async {
    await _backendAsAService.changePassword(newPassword);
  }

  Future<void> signOut() async {
    await _backendAsAService.signOut();
  }
}
