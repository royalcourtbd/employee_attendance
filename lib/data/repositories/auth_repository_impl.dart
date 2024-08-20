// lib/data/repositories/auth_repository_impl.dart

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepositoryImpl(this._firebaseAuth, this._firestore);

  @override
  Future<Either<String, User>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = await _getUserFromFirestore(userCredential.user!.uid);
      return right(user);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return right(null);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, User>> getCurrentUser() async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) {
        return left('No user logged in');
      }
      final user = await _getUserFromFirestore(firebaseUser.uid);
      return right(user);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> updateDeviceToken(String token) async {
    try {
      final userId = _firebaseAuth.currentUser?.uid;
      if (userId == null) {
        return left('No user logged in');
      }
      await _firestore.collection('users').doc(userId).update({
        'deviceToken': token,
      });
      return right(null);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Stream<User?> userStream() {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) {
        return null;
      }
      return await _getUserFromFirestore(firebaseUser.uid);
    });
  }

  Future<User> _getUserFromFirestore(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    final data = doc.data() as Map<String, dynamic>;
    return User(
      id: uid,
      name: data['name'],
      joiningDate: data['joiningDate']?.toDate(),
      image: data['image'],
      employeeId: data['employeeId'],
      documentId: data['documentId'],
      phoneNumber: data['phoneNumber'],
      deviceToken: data['deviceToken'],
      isEmployee: data['isEmployee'] ?? true,
      email: data['email'],
      designation: data['designation'],
    );
  }
}
