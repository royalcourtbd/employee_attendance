import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/presentation/login/presenter/login_page_ui_state.dart';
import 'package:employee_attendance/presentation/main/ui/main_page.dart';
import 'package:flutter/material.dart';

class LoginPagePresenter extends BasePresenter<LoginPageUiState> {
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
      await toggleLoading(loading: true);

      await Future.delayed(const Duration(seconds: 5));

      await toggleLoading(loading: false);
      await showMessage(message: 'Login successful');

      context.navigatorPushReplacement(MainPage());
    }
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
