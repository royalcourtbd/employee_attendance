import 'package:employee_attendance/core/services/firebase_service.dart';
import 'package:employee_attendance/data/models/user_model.dart';
import 'package:employee_attendance/domain/entities/user.dart';
import 'package:employee_attendance/domain/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseService _firebaseService;

  UserRepositoryImpl(this._firebaseService);

  Stream<firebase_auth.User?> get authStateChanges =>
      _firebaseService.auth.authStateChanges();

  firebase_auth.User? get currentUser => _firebaseService.auth.currentUser;

  @override
  Future<User?> createDemoUser() async {
    try {
      final userCredential =
          await _firebaseService.auth.createUserWithEmailAndPassword(
        email: 'admin@admin.com',
        password: '123456',
      );

      final user = UserModel(
        id: userCredential.user!.uid,
        name: 'Demo User',
        role: 'employee',
        joiningDate: DateTime.now(),
        email: 'demo@example.com',
        employeeStatus: true,
      );

      await _firebaseService.firestore
          .collection('users')
          .doc(user.id)
          .set(user.toJson());

      return user;
    } catch (e) {
      debugPrint('Error creating demo user: $e');
      return null;
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential =
          await _firebaseService.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await fetchUserData(userCredential.user!.uid);
    } catch (e) {
      debugPrint('Error logging in: $e');
      return null;
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseService.auth.signOut();
  }

  @override
  Future<User?> fetchUserData(String userId) async {
    try {
      final doc = await _firebaseService.firestore
          .collection('users')
          .doc(userId)
          .get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching user data: $e');
      return null;
    }
  }

  @override
  Future<void> updateUser(User user) async {
    try {
      final UserModel userModel = UserModel.fromUser(user);
      await _firebaseService.firestore
          .collection('users')
          .doc(user.id)
          .update((userModel.toJson()));
    } catch (e) {
      debugPrint('Error updating user: $e');
    }
  }

  @override
  Stream<User?> getUserStream(String userId) {
    return _firebaseService.firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((doc) {
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
      return null;
    });
  }

  @override
  Future<String?> getDeviceToken() {
    return _firebaseService.getDeviceToken();
  }
}
