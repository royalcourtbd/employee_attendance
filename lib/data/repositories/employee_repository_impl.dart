import 'dart:async';
import 'dart:developer';
import 'package:employee_attendance/core/services/firebase_service.dart';
import 'package:employee_attendance/core/static/urls.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/data/models/employee_user_model.dart';
import 'package:employee_attendance/domain/entities/employee_entity.dart';
import 'package:employee_attendance/domain/repositories/employee_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final FirebaseService _firebaseService;

  EmployeeRepositoryImpl(this._firebaseService);

  Stream<firebase_auth.User?> get authStateChanges =>
      _firebaseService.auth.authStateChanges();

  firebase_auth.User? get currentUser => _firebaseService.auth.currentUser;

  @override
  Future<EmployeeEntity?> createDemoUser() async {
    try {
      const email = 'dfhg@jfdg.com';
      const password = '123456';

      // Store the current user
      // final currentUser = _firebaseService.auth.currentUser;

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
            email: currentUser!.email!, password: password);
      }

      return employeeModel;
    } catch (e) {
      log('Error creating demo user: $e');
      return null;
    }
  }

  @override
  Future<void> addEmployee(EmployeeEntity employee) async {
    try {
      const password = '123456';

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
            email: currentUser!.email!, password: password);
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
      log('Error getting last employee ID: $e');
      return null;
    }
  }

  @override
  Future<EmployeeEntity?> fetchUserData(String userId) async {
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
  Future<void> updateUser(EmployeeEntity user) async {
    try {
      final EmployeeUserModel userModel = EmployeeUserModel.fromEntity(user);
      await _firebaseService.firestore
          .collection(Urls.employees)
          .doc(user.id)
          .update((userModel.toJson()));
    } catch (e) {
      debugPrint('Error updating user: $e');
    }
  }

  @override
  Stream<EmployeeEntity?> getUserStream(String userId) {
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
