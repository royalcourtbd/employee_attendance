import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/domain/entities/user.dart';
import 'package:employee_attendance/domain/usecases/auth_use_case.dart';
import 'package:employee_attendance/presentation/admin/ui/admin_dashboard_page.dart';
import 'package:employee_attendance/presentation/login/presenter/login_page_ui_state.dart';
import 'package:employee_attendance/presentation/main/ui/main_page.dart';
import 'package:flutter/material.dart';

class LoginPagePresenter extends BasePresenter<LoginPageUiState> {
  final AuthUseCase _authUseCase;

  LoginPagePresenter(this._authUseCase);
  final Obs<LoginPageUiState> uiState = Obs(LoginPageUiState.empty());
  LoginPageUiState get currentUiState => uiState.value;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    String pattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void handleLogin(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await toggleLoading(loading: true);
      final result = await _authUseCase.signIn(
          email: currentUiState.email, password: currentUiState.password);

      await result.fold((error) async {
        await showMessage(message: error);
      }, (user) async {
        await addUserMessage('Login successful! Redirecting...');
        _navigateBasedOnUserRole(context, user);
      });

      await toggleLoading(loading: false);
    }
  }

  void _navigateBasedOnUserRole(BuildContext context, User user) {
    if (user.isEmployee) {
      context.navigatorPushReplacement(MainPage());
    } else {
      // Navigate to admin page
      context.navigatorPushReplacement(const AdminDashboardPage());
    }
  }

  void updateEmail({required String email}) {
    uiState.value = currentUiState.copyWith(email: email);
  }

  void updatePassword({required String password}) {
    uiState.value = currentUiState.copyWith(password: password);
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
