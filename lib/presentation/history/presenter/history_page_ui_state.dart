import 'package:employee_attendance/core/base/base_ui_state.dart';
import 'package:employee_attendance/domain/entities/attendance.dart';

class HistoryPageUiState extends BaseUiState {
  const HistoryPageUiState({
    required super.isLoading,
    required super.userMessage,
    required this.attendances,
  });

  factory HistoryPageUiState.empty() {
    return const HistoryPageUiState(
      isLoading: false,
      userMessage: '',
      attendances: [],
    );
  }

  final List<Attendance> attendances;

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        attendances,
      ];

  HistoryPageUiState copyWith({
    bool? isLoading,
    String? userMessage,
    List<Attendance>? attendances,
  }) {
    return HistoryPageUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      attendances: attendances ?? this.attendances,
    );
  }
}
