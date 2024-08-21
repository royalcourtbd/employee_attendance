import 'package:employee_attendance/core/base/base_ui_state.dart';
import 'package:employee_attendance/domain/entities/user.dart';

class ProfilePageUiState extends BaseUiState {
  final User? user;

  const ProfilePageUiState({
    required super.isLoading,
    required super.userMessage,
    this.user,
  });

  factory ProfilePageUiState.empty() {
    return const ProfilePageUiState(
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

  ProfilePageUiState copyWith({
    bool? isLoading,
    String? userMessage,
    User? user,
  }) {
    return ProfilePageUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      user: user ?? this.user,
    );
  }
}
