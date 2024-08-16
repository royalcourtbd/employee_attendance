import 'package:employee_attendance/core/base/base_ui_state.dart';

class LoginPageUiState extends BaseUiState {
  const LoginPageUiState({
    required super.isLoading,
    required super.userMessage,
  });

  factory LoginPageUiState.empty() {
    return const LoginPageUiState(
      isLoading: false,
      userMessage: '',
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
      ];

  LoginPageUiState copyWith({
    bool? isLoading,
    String? userMessage,
  }) {
    return LoginPageUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
    );
  }
}
