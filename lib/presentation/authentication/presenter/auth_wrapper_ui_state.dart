import 'package:employee_attendance/core/base/base_ui_state.dart';

class AuthWrapperUiState extends BaseUiState {
  const AuthWrapperUiState({
    required super.isLoading,
    required super.userMessage,
  });

  factory AuthWrapperUiState.empty() {
    return const AuthWrapperUiState(
      isLoading: false,
      userMessage: '',
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
      ];

  AuthWrapperUiState copyWith({
    bool? isLoading,
    String? userMessage,
  }) {
    return AuthWrapperUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
    );
  }
}
