import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:employee_attendance/domain/usecases/create_demo_user_use_case.dart';
import 'package:employee_attendance/domain/usecases/get_device_token_use_case.dart';
import 'package:employee_attendance/domain/usecases/login_use_case.dart';
import 'package:employee_attendance/domain/usecases/update_user_use_case.dart';
import 'package:employee_attendance/presentation/login/presenter/login_page_ui_state.dart';
import 'package:employee_attendance/presentation/main/presenter/main_page_presenter.dart';

import 'package:flutter/material.dart';

class LoginPagePresenter extends BasePresenter<LoginPageUiState> {
  final LoginUseCase _loginUseCase;
  final CreateDemoUserUseCase _createDemoUserUseCase;
  final GetDeviceTokenUseCase _getDeviceTokenUseCase;
  final UpdateUserUseCase _updateUserUseCase;
  LoginPagePresenter(
    this._createDemoUserUseCase,
    this._loginUseCase,
    this._updateUserUseCase,
    this._getDeviceTokenUseCase,
  );

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
      final result = await _loginUseCase.execute(email, password);
      await toggleLoading(loading: false);

      result.fold(
        (errorMessage) async {
          await addUserMessage(errorMessage);
        },
        (Employee? user) async {
          if (user != null) {
            final String? deviceToken = await _getDeviceTokenUseCase.execute();
            _mainPagePresenter.updateIndex(index: 0);

            if (deviceToken != null && deviceToken.isNotEmpty) {
              debugPrint('Device Token: $deviceToken');
              await _updateUserUseCase
                  .execute(user.copyWith(deviceToken: deviceToken));
              await addUserMessage('Logged in successfully');
            }
          } else {
            await addUserMessage(
                'An error occurred while logging in. Please try again.');
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
    final demoEmployee = await _createDemoUserUseCase.execute();
    await toggleLoading(loading: false);

    if (demoEmployee != null) {
      await addUserMessage('Demo user created successfully');
    } else {
      await addUserMessage(
          'An error occurred while creating demo user. Please try again.');
    }
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
    return showMessage(message: currentUiState.userMessage);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
