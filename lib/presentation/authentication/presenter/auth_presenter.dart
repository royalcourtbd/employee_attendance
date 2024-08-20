// lib/presentation/auth/presenter/auth_presenter.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/domain/entities/user.dart';
import 'package:employee_attendance/presentation/authentication/presenter/auth_ui_state.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../../core/base/base_presenter.dart';
import '../../../domain/usecases/auth_use_case.dart';

class AuthPresenter extends BasePresenter<AuthUiState> {
  final AuthUseCase _authUseCase;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthPresenter(this._authUseCase, this._firebaseAuth, this._firestore);

  final Obs<AuthUiState> uiState = Obs(AuthUiState.empty());

  AuthUiState get currentUiState => uiState.value;

  Future<void> signIn({required String email, required String password}) async {
    await toggleLoading(loading: true);
    final result = await _authUseCase.signIn(email: email, password: password);
    result.fold(
      (error) => addUserMessage(error),
      (user) => uiState.value = currentUiState.copyWith(user: user),
    );
    await toggleLoading(loading: false);
  }

  Future<void> signOut() async {
    await toggleLoading(loading: true);
    final result = await _authUseCase.signOut();
    result.fold(
      (error) => addUserMessage(error),
      (_) => uiState.value = currentUiState.copyWith(user: null),
    );
    await toggleLoading(loading: false);
  }

  Future<void> getCurrentUser() async {
    await toggleLoading(loading: true);
    final result = await _authUseCase.getCurrentUser();
    result.fold(
      (error) => addUserMessage(error),
      (user) => uiState.value = currentUiState.copyWith(user: user),
    );
    await toggleLoading(loading: false);
  }

  Future<void> updateDeviceToken(String token) async {
    final result = await _authUseCase.updateDeviceToken(token);
    result.fold(
      (error) => addUserMessage(error),
      (_) {},
    );
  }

  void startUserStream() {
    _authUseCase.userStream().listen((user) {
      uiState.value = currentUiState.copyWith(user: user);
    });
  }

  Future<void> createDemoUser({required bool isEmployee}) async {
    await toggleLoading(loading: true);
    try {
      // ডেমো ইউজার তৈরি
      final String email =
          isEmployee ? 'demo_employee@example.com' : 'demo_admin@example.com';
      const String password = '123456';

      // Firebase Auth এ ইউজার তৈরি
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Firestore এ ইউজার ডেটা সেভ
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': isEmployee ? 'ডেমো কর্মচারী' : 'ডেমো অ্যাডমিন',
        'email': email,
        'isEmployee': isEmployee,
        'joiningDate': DateTime.now(),
        'employeeId': isEmployee ? 'EMP001' : 'ADM001',
        'deviceToken': 'demo_token',
      });

      // ইউজার অবজেক্ট তৈরি
      final user = User(
        id: userCredential.user!.uid,
        name: isEmployee ? 'ডেমো কর্মচারী' : 'ডেমো অ্যাডমিন',
        email: email,
        isEmployee: isEmployee,
        joiningDate: DateTime.now(),
        employeeId: isEmployee ? 'EMP001' : 'ADM001',
        deviceToken: 'demo_token',
      );

      // UI আপডেট
      uiState.value = currentUiState.copyWith(user: user);
      await showMessage(message: 'ডেমো ইউজার তৈরি হয়েছে');
    } catch (e) {
      await showMessage(
          message: 'ডেমো ইউজার তৈরি করতে ব্যর্থ: ${e.toString()}');
    }
    await toggleLoading(loading: false);
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
