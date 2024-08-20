// lib/domain/repositories/auth_repository.dart

import 'package:fpdart/fpdart.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<String, User>> signIn({
    required String email,
    required String password,
  });
  Future<Either<String, void>> signOut();
  Future<Either<String, User>> getCurrentUser();
  Future<Either<String, void>> updateDeviceToken(String token);
  Stream<User?> userStream();
}
