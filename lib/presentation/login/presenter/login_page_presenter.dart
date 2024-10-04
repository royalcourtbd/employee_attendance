import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:employee_attendance/domain/usecases/employee_usecases.dart';
import 'package:employee_attendance/presentation/login/presenter/login_page_ui_state.dart';
import 'package:employee_attendance/presentation/main/presenter/main_page_presenter.dart';

import 'package:flutter/material.dart';

class LoginPagePresenter extends BasePresenter<LoginPageUiState> {
  final EmployeeUseCases _userUseCases;
  LoginPagePresenter(this._userUseCases);

  final Obs<LoginPageUiState> uiState = Obs(LoginPageUiState.empty());
  LoginPageUiState get currentUiState => uiState.value;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final MainPagePresenter _mainPagePresenter = locate<MainPagePresenter>();

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

  Future<void> handleLogin(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final String email = currentUiState.email.trim();
      final String password = currentUiState.password.trim();

      await toggleLoading(loading: true);
      final result = await _userUseCases.login(email, password);
      await toggleLoading(loading: false);

      result.fold(
        (errorMessage) async {
          await addUserMessage(errorMessage);
          showMessage(message: currentUiState.userMessage);
        },
        (Employee? user) async {
          if (user != null) {
            final String? deviceToken = await _userUseCases.getDeviceToken();
            _mainPagePresenter.updateIndex(index: 0);

            if (deviceToken != null && deviceToken.isNotEmpty) {
              debugPrint('Device Token: $deviceToken');
              await _userUseCases
                  .updateUser(user.copyWith(deviceToken: deviceToken));
              await addUserMessage('Logged in successfully');
              showMessage(message: currentUiState.userMessage);
            }
          } else {
            await addUserMessage(
                'An error occurred while logging in. Please try again.');
            showMessage(message: currentUiState.userMessage);
          }
        },
      );
    }
  }

  void updateEmail({required String email}) {
    uiState.value = currentUiState.copyWith(email: email);
  }

  void updatePassword({required String password}) {
    uiState.value = currentUiState.copyWith(password: password);
  }

  Future<void> createDemoUser() async {
    await toggleLoading(loading: true);
    final user = await _userUseCases.createDemoUser();
    await toggleLoading(loading: false);

    if (user != null) {
      await addUserMessage('ডেমো ইউজার সফলভাবে তৈরি করা হয়েছে।');
      showMessage(message: currentUiState.userMessage);
    } else {
      await addUserMessage(
          'ডেমো ইউজার তৈরি করতে ব্যর্থ হয়েছে। অনুগ্রহ করে আবার চেষ্টা করুন।');
      showMessage(message: currentUiState.userMessage);
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
