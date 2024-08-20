// lib/presentation/auth/presenter/auth_ui_state.dart

import '../../../core/base/base_ui_state.dart';
import '../../../domain/entities/user.dart';

class AuthUiState extends BaseUiState {
  final User? user;

  const AuthUiState({
    required super.isLoading,
    required super.userMessage,
    this.user,
  });

  factory AuthUiState.empty() {
    return const AuthUiState(
      isLoading: false,
      userMessage: '',
      user: null,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        user,
      ];

  AuthUiState copyWith({
    bool? isLoading,
    String? userMessage,
    User? user,
  }) {
    return AuthUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      user: user ?? this.user,
    );
  }
}
