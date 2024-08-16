import 'package:employee_attendance/core/base/base_ui_state.dart';

class ProfilePageUiState extends BaseUiState {
  const ProfilePageUiState({
    required super.isLoading,
    required super.userMessage,
  });

  factory ProfilePageUiState.empty() {
    return const ProfilePageUiState(
      isLoading: false,
      userMessage: '',
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
      ];

  ProfilePageUiState copyWith({
    bool? isLoading,
    String? userMessage,
  }) {
    return ProfilePageUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
    );
  }
}
