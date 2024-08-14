import 'package:employee_attendance/core/base/base_ui_state.dart';

class NotificationUiState extends BaseUiState {
  const NotificationUiState({
    required super.isLoading,
    required super.userMessage,
  });

  factory NotificationUiState.empty() {
    return const NotificationUiState(
      isLoading: false,
      userMessage: '',
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
      ];

  NotificationUiState copyWith({
    bool? isLoading,
    String? userMessage,
  }) {
    return NotificationUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
    );
  }
}
