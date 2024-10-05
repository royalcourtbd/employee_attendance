import 'package:employee_attendance/core/base/base_ui_state.dart';
import 'package:employee_attendance/domain/entities/attendance.dart';

class TodaysAttendanceUiState extends BaseUiState {
  final List<Attendance> attendances;

  const TodaysAttendanceUiState({
    required super.isLoading,
    required super.userMessage,
    required this.attendances,
  });

  factory TodaysAttendanceUiState.empty() {
    return const TodaysAttendanceUiState(
      isLoading: false,
      userMessage: '',
      attendances: [],
    );
  }

  @override
  List<Object?> get props => [isLoading, userMessage, attendances];

  TodaysAttendanceUiState copyWith({
    bool? isLoading,
    String? userMessage,
    List<Attendance>? attendances,
  }) {
    return TodaysAttendanceUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      attendances: attendances ?? this.attendances,
    );
  }
}
