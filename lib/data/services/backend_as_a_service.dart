import 'dart:async';
import 'dart:io';

import 'package:employee_attendance/core/services/firebase_service.dart';
import 'package:employee_attendance/core/static/urls.dart';
import 'package:employee_attendance/data/models/employee_user_model.dart';
import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class BackendAsAService {
  final FirebaseService _firebaseService;

  BackendAsAService(this._firebaseService);
  Future<Either<String, Employee?>> signIn(
          String email, String password) async =>
      _signIn(email, password);

  Future<void> signOut() async => _signOut();

  Future<Either<String, Employee?>> _signIn(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseService.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      //     final Employee? user = await fetchUserData(userCredential.user!.uid);
      //     return Right(user);

      final doc = await _firebaseService.firestore
          .collection(Urls.employees)
          .doc(userCredential.user!.uid)
          .get();

      if (doc.exists) {
        final employee = EmployeeUserModel.fromJson(doc.data()!);
        return Right(employee);
      }
      return const Right(null);
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const Left('No user found for this email');
      } else if (e.code == 'wrong-password') {
        return const Left('Wrong password provided for this user');
      } else {
        return const Left('Invalid email');
      }
    } on SocketException catch (_) {
      return const Left('No internet connection');
    } on TimeoutException catch (_) {
      return const Left('Request timed out');
    } catch (e) {
      return const Left('An error occurred');
    }
  }

  Future<void> _signOut() async {
    await _firebaseService.auth.signOut();
  }
}
