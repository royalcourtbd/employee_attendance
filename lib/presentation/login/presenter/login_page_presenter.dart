import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/presentation/login/presenter/login_page_ui_state.dart';
import 'package:employee_attendance/presentation/main/ui/main_page.dart';
import 'package:flutter/material.dart';

class LoginPagePresenter extends BasePresenter<LoginPageUiState> {
  final Obs<LoginPageUiState> uiState = Obs(LoginPageUiState.empty());
  LoginPageUiState get currentUiState => uiState.value;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void updateEmail({required String email}) {
    uiState.value = currentUiState.copyWith(email: email);
  }

  void updatePassword({required String password}) {
    uiState.value = currentUiState.copyWith(password: password);
  }

  void handleLogin(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      login().then((_) {
        context.navigatorPushReplacement(MainPage());
      });
    }
  }

  Future<void> login() async {
    await toggleLoading(loading: true);
    // Implement login logic here
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
