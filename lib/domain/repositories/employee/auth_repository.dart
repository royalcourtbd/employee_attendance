import 'package:employee_attendance/domain/entities/employee_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<String, EmployeeEntity?>> login(String email, String password);
  Future<void> logout();
  Future<void> changePassword(String newPassword);
}
