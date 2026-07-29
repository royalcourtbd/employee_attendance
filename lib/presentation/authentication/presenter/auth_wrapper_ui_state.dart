import 'package:employee_attendance/core/base/base_ui_state.dart';

enum AuthState {
  loggedOut,
  loggedInAdmin,
  loggedInEmployee,
}

class AuthWrapperUiState extends BaseUiState {
  const AuthWrapperUiState({
    required super.isLoading,
    required super.userMessage,
    required this.authState,
  });

  final AuthState? authState;

  factory AuthWrapperUiState.empty() {
    return const AuthWrapperUiState(
      isLoading: false,
      userMessage: '',
      authState: null,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        authState,
      ];

  AuthWrapperUiState copyWith({
    bool? isLoading,
    String? userMessage,
    AuthState? authState,
  }) {
    return AuthWrapperUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      authState: authState ?? this.authState,
    );
  }
}
