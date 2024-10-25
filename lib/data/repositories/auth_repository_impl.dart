import 'package:employee_attendance/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:employee_attendance/domain/entities/employee_entity.dart';
import 'package:employee_attendance/domain/repositories/employee/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<Either<String, EmployeeEntity?>> login(String email, String password) {
    final Future<Either<String, EmployeeEntity?>> login =
        _authRemoteDataSource.login(email, password);
    return login;
  }

  @override
  Future<void> logout() {
    final Future<void> signOut = _authRemoteDataSource.signOut();
    return signOut;
  }

  @override
  Future<void> changePassword(String newPassword) {
    final Future<void> changePassword =
        _authRemoteDataSource.changePassword(newPassword);
    return changePassword;
  }
}
