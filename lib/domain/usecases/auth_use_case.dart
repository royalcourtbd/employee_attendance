// lib/domain/usecases/auth_use_case.dart

import 'package:fpdart/fpdart.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<Either<String, User>> signIn({
    required String email,
    required String password,
  }) {
    return _authRepository.signIn(email: email, password: password);
  }

  Future<Either<String, void>> signOut() {
    return _authRepository.signOut();
  }

  Future<Either<String, User>> getCurrentUser() {
    return _authRepository.getCurrentUser();
  }

  Future<Either<String, void>> updateDeviceToken(String token) {
    return _authRepository.updateDeviceToken(token);
  }

  Stream<User?> userStream() {
    return _authRepository.userStream();
  }
}
