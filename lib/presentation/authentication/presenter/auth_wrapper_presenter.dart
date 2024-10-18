// lib/presentation/authentication/presenter/auth_wrapper_presenter.dart

import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/data/repositories/employee_repository_impl.dart';
import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:employee_attendance/domain/repositories/employee_repository.dart';
import 'package:employee_attendance/presentation/authentication/presenter/auth_wrapper_ui_state.dart';
import 'package:employee_attendance/presentation/profile/presenter/profile_page_presenter.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

enum AuthState {
  loading,
  loggedOut,
  loggedInAdmin,
  loggedInEmployee,
}

class AuthWrapperPresenter extends BasePresenter<AuthWrapperUiState> {
  final EmployeeRepository _userRepository = locate<EmployeeRepository>();
  final ProfilePagePresenter _profilePagePresenter =
      locate<ProfilePagePresenter>();

  final Obs<AuthWrapperUiState> uiState = Obs(AuthWrapperUiState.empty());
  AuthWrapperUiState get currentUiState => uiState.value;

  Stream<AuthState> get authStateStream =>
      (_userRepository as EmployeeRepositoryImpl)
          .authStateChanges
          .asyncMap(_mapUserToAuthState);

  Future<AuthState> _mapUserToAuthState(firebase_auth.User? user) async {
    if (user == null) {
      return AuthState.loggedOut;
    }

    _profilePagePresenter.initUserStream(user.uid);
    final Employee? appUser = await _userRepository.fetchUserData(user.uid);

    if (appUser == null) {
      await _profilePagePresenter.logout();
      return AuthState.loggedOut;
    }

    return appUser.role == 'admin'
        ? AuthState.loggedInAdmin
        : AuthState.loggedInEmployee;
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
