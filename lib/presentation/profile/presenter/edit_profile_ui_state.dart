import 'package:employee_attendance/core/base/base_ui_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileUiState extends BaseUiState {
  final User? user;

  const EditProfileUiState({
    required super.isLoading,
    required super.userMessage,
    this.user,
  });

  factory EditProfileUiState.empty() {
    return const EditProfileUiState(
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

  EditProfileUiState copyWith({
    bool? isLoading,
    String? userMessage,
    User? user,
  }) {
    return EditProfileUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      user: user ?? this.user,
    );
  }
}
