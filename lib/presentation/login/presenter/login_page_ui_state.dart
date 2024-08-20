// lib/presentation/login/presenter/login_page_ui_state.dart

import 'package:employee_attendance/core/base/base_ui_state.dart';

class LoginPageUiState extends BaseUiState {
  final String email;
  final String password;

  const LoginPageUiState({
    required super.isLoading,
    required super.userMessage,
    required this.email,
    required this.password,
  });

  factory LoginPageUiState.empty() {
    return const LoginPageUiState(
      isLoading: false,
      userMessage: '',
      email: '',
      password: '',
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        email,
        password,
      ];

  LoginPageUiState copyWith({
    bool? isLoading,
    String? userMessage,
    String? email,
    String? password,
  }) {
    return LoginPageUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
