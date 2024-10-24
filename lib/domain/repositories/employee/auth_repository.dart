import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<String, Employee?>> login(String email, String password);
  Future<void> logout();
  Future<void> changePassword(String newPassword);
}
