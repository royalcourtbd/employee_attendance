import 'package:employee_attendance/core/base/base_ui_state.dart';

class EditProfileUiState extends BaseUiState {
  const EditProfileUiState({
    required super.isLoading,
    required super.userMessage,
  });

  factory EditProfileUiState.empty() {
    return const EditProfileUiState(
      isLoading: false,
      userMessage: '',
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
      ];

  EditProfileUiState copyWith({
    bool? isLoading,
    String? userMessage,
  }) {
    return EditProfileUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
    );
  }
}
