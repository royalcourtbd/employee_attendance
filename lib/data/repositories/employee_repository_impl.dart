import 'dart:async';
import 'dart:io';

import 'package:employee_attendance/core/services/firebase_service.dart';
import 'package:employee_attendance/core/static/urls.dart';
import 'package:employee_attendance/data/models/employee_user_model.dart';
import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:employee_attendance/domain/repositories/employee_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final FirebaseService _firebaseService;

  EmployeeRepositoryImpl(this._firebaseService);

  Stream<firebase_auth.User?> get authStateChanges =>
      _firebaseService.auth.authStateChanges();

  firebase_auth.User? get currentUser => _firebaseService.auth.currentUser;

  @override
  Future<Employee?> createDemoUser() async {
    try {
      final userCredential =
          await _firebaseService.auth.createUserWithEmailAndPassword(
        email: 'demo@demo.com',
        password: '123456',
      );

      final employeeModel = EmployeeUserModel(
        id: userCredential.user!.uid,
        name: 'Demo User',
        role: 'employee',
        joiningDate: DateTime.now(),
        email: 'demo@example.com',
        employeeStatus: true,
      );

      await _firebaseService.firestore
          .collection(Urls.employees)
          .doc(employeeModel.id)
          .set(employeeModel.toJson());

      return employeeModel;
    } catch (e) {
      debugPrint('Error creating demo user: $e');
      return null;
    }
  }

  @override
  Future<Either<String, Employee?>> login(String email, String password) async {
    try {
      final userCredential =
          await _firebaseService.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final Employee? user = await fetchUserData(userCredential.user!.uid);
      return Right(user);
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
      debugPrint('Error logging in: $e');
      return const Left('An error occurred');
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseService.auth.signOut();
  }

  @override
  Future<Employee?> fetchUserData(String userId) async {
    try {
      final doc = await _firebaseService.firestore
          .collection(Urls.employees)
          .doc(userId)
          .get();
      if (doc.exists) {
        return EmployeeUserModel.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching user data: $e');
      return null;
    }
  }

  @override
  Future<void> updateUser(Employee user) async {
    try {
      final EmployeeUserModel userModel = EmployeeUserModel.fromUser(user);
      await _firebaseService.firestore
          .collection(Urls.employees)
          .doc(user.id)
          .update((userModel.toJson()));
    } catch (e) {
      debugPrint('Error updating user: $e');
    }
  }

  @override
  Stream<Employee?> getUserStream(String userId) {
    return _firebaseService.firestore
        .collection(Urls.employees)
        .doc(userId)
        .snapshots()
        .map((doc) {
      if (doc.exists) {
        return EmployeeUserModel.fromJson(doc.data()!);
      }
      return null;
    });
  }

  @override
  Future<String?> getDeviceToken() {
    return _firebaseService.getDeviceToken();
  }

  @override
  Stream<List<Employee>> getAllEmployees() {
    return _firebaseService.firestore
        .collection(Urls.employees)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => EmployeeUserModel.fromJson(doc.data()))
          .toList();
    });
  }
}
