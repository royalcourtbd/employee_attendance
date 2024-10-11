import 'dart:async';
import 'dart:io';

import 'package:employee_attendance/core/services/firebase_service.dart';
import 'package:employee_attendance/core/static/urls.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/data/models/employee_user_model.dart';
import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:employee_attendance/domain/repositories/employee_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
      const email = 'dfhg@jfdg.com';
      const password = '123456';

      // Store the current user
      final currentUser = _firebaseService.auth.currentUser;

      // Create a secondary Firebase Auth instance
      final secondaryApp = await Firebase.initializeApp(
          name: 'SecondaryApp', options: Firebase.app().options);

      final secondaryAuth =
          firebase_auth.FirebaseAuth.instanceFor(app: secondaryApp);

      // Create user with secondary Auth instance
      final userCredential = await secondaryAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final employeeModel = EmployeeUserModel(
        id: userCredential.user!.uid,
        name: 'Demo User',
        role: 'employee',
        joiningDate: DateTime.now(),
        email: email,
        employeeStatus: true,
      );

      await _firebaseService.firestore
          .collection(Urls.employees)
          .doc(employeeModel.id)
          .set(employeeModel.toJson());

      // Delete the secondary app
      await secondaryApp.delete();

      // If there was a user logged in before, make sure they're still logged in
      if (currentUser != null) {
        await _firebaseService.auth.signInWithEmailAndPassword(
            email: currentUser.email!,
            password:
                password // You'll need to handle this securely in a real app
            );
      }

      return employeeModel;
    } catch (e) {
      debugPrint('Error creating demo user: $e');
      return null;
    }
  }

  @override
  Future<void> addEmployee(Employee employee) async {
    try {
      const password = '123456';

      final currentUser = _firebaseService.auth.currentUser;

      final secondaryApp = await Firebase.initializeApp(
          name: 'SecondaryApp', options: Firebase.app().options);

      final secondaryAuth =
          firebase_auth.FirebaseAuth.instanceFor(app: secondaryApp);

      final userCredential = await secondaryAuth.createUserWithEmailAndPassword(
        email: employee.email!,
        password: password,
      );

      final employeeModel = EmployeeUserModel(
        id: userCredential.user!.uid,
        documentId: userCredential.user!.uid,
        name: employee.name,
        email: employee.email,
        role: employee.role,
        employeeId: employee.employeeId,
        designation: employee.designation,
        joiningDate: employee.joiningDate,
        phoneNumber: employee.phoneNumber,
        employeeStatus: employee.employeeStatus,
      );

      await _firebaseService.firestore
          .collection(Urls.employees)
          .doc(employeeModel.id)
          .set(employeeModel.toJson());

      // Delete the secondary app
      await secondaryApp.delete();

      // If there was a user logged in before, make sure they're still logged in
      if (currentUser != null) {
        await _firebaseService.auth.signInWithEmailAndPassword(
            email: currentUser.email!,
            password:
                password // You'll need to handle this securely in a real app
            );
      }
    } catch (e) {
      showMessage(message: 'Failed to add employee: $e');
      rethrow;
    }
  }

  @override
  Future<String?> getLastEmployeeId() async {
    try {
      final querySnapshot = await _firebaseService.firestore
          .collection(Urls.employees)
          .orderBy('employeeId', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.get('employeeId') as String?;
      }
      return null;
    } catch (e) {
      debugPrint('Error getting last employee ID: $e');
      return null;
    }
  }

  @override
  Future<Either<String, Employee?>> login(String email, String password) async {
    try {
      final UserCredential userCredential =
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
      return const Left('An error occurred');
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseService.auth.signOut();
  }

  @override
  Future<void> changePassword(String newPassword) async {
    try {
      final user = _firebaseService.auth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
      } else {
        throw Exception('No user is currently signed in.');
      }
    } catch (e) {
      throw Exception('Failed to change password: $e');
    }
  }

  @override
  Future<Employee?> fetchUserData(String userId) async {
    try {
      final doc = await _firebaseService.firestore
          .collection(Urls.employees)
          .doc(userId)
          .get();
      if (doc.exists) {
        final data = doc.data()!;

        final employee = EmployeeUserModel.fromJson(data);

        return employee;
      }

      return null;
    } catch (e) {
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
  Stream<List<EmployeeUserModel>> getAllEmployees() {
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
