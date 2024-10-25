// lib/presentation/admin/attendance/presenter/todays_attendance_ui_state.dart

import 'package:employee_attendance/core/base/base_ui_state.dart';
import 'package:employee_attendance/domain/entities/attendance_entity.dart';
import 'package:employee_attendance/domain/entities/employee_entity.dart';

class AttendanceWithEmployee {
  final AttendanceEntity attendance;
  final EmployeeEntity employee;

  AttendanceWithEmployee({required this.attendance, required this.employee});
}

class AttendanceSummary {
  final int totalPresent;
  final int totalLate;

  AttendanceSummary({required this.totalPresent, required this.totalLate});
}

enum SortCriteria { checkInTime, name }

class TodaysAttendanceUiState extends BaseUiState {
  final List<AttendanceWithEmployee> attendancesWithEmployee;
  final List<AttendanceWithEmployee> filteredAttendancesWithEmployee;
  final AttendanceSummary summary;
  final SortCriteria sortCriteria;

  const TodaysAttendanceUiState({
    required super.isLoading,
    required super.userMessage,
    required this.attendancesWithEmployee,
    required this.filteredAttendancesWithEmployee,
    required this.summary,
    required this.sortCriteria,
  });

  factory TodaysAttendanceUiState.empty() {
    return TodaysAttendanceUiState(
      isLoading: false,
      userMessage: '',
      attendancesWithEmployee: const [],
      filteredAttendancesWithEmployee: const [],
      summary: AttendanceSummary(totalPresent: 0, totalLate: 0),
      sortCriteria: SortCriteria.checkInTime,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        attendancesWithEmployee,
        filteredAttendancesWithEmployee,
        summary,
        sortCriteria
      ];

  TodaysAttendanceUiState copyWith({
    bool? isLoading,
    String? userMessage,
    List<AttendanceWithEmployee>? attendancesWithEmployee,
    List<AttendanceWithEmployee>? filteredAttendancesWithEmployee,
    AttendanceSummary? summary,
    SortCriteria? sortCriteria,
  }) {
    return TodaysAttendanceUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      attendancesWithEmployee:
          attendancesWithEmployee ?? this.attendancesWithEmployee,
      filteredAttendancesWithEmployee: filteredAttendancesWithEmployee ??
          this.filteredAttendancesWithEmployee,
      summary: summary ?? this.summary,
      sortCriteria: sortCriteria ?? this.sortCriteria,
    );
  }
}
