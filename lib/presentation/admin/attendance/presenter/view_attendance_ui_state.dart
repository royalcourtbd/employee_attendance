import 'package:employee_attendance/core/base/base_ui_state.dart';

class ViewAttendanceUiState extends BaseUiState {
  const ViewAttendanceUiState({
    required super.isLoading,
    required super.userMessage,
  });

  factory ViewAttendanceUiState.empty() {
    return const ViewAttendanceUiState(
      isLoading: false,
      userMessage: '',
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
      ];

  ViewAttendanceUiState copyWith({
    bool? isLoading,
    String? userMessage,
  }) {
    return ViewAttendanceUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
    );
  }
}
