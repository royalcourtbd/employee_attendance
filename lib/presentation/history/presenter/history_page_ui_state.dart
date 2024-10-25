// lib/presentation/history/presenter/history_page_ui_state.dart ফাইলে

import 'package:employee_attendance/core/base/base_ui_state.dart';
import 'package:employee_attendance/domain/entities/attendance_entity.dart';
import 'package:employee_attendance/domain/service/holiday_service.dart';

class HistoryPageUiState extends BaseUiState {
  const HistoryPageUiState({
    required super.isLoading,
    required super.userMessage,
    required this.filteredAttendances,
    required this.selectedMonth,
    required this.monthHolidays,
  });

  factory HistoryPageUiState.empty() {
    return HistoryPageUiState(
      isLoading: false,
      userMessage: '',
      filteredAttendances: const [],
      selectedMonth: DateTime.now(),
      monthHolidays: const [],
    );
  }

  final List<AttendanceEntity> filteredAttendances;
  final DateTime selectedMonth;
  final List<Holiday> monthHolidays;

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        filteredAttendances,
        selectedMonth,
        monthHolidays,
      ];

  HistoryPageUiState copyWith({
    bool? isLoading,
    String? userMessage,
    List<AttendanceEntity>? filteredAttendances,
    DateTime? selectedMonth,
    List<Holiday>? monthHolidays,
  }) {
    return HistoryPageUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      filteredAttendances: filteredAttendances ?? this.filteredAttendances,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      monthHolidays: monthHolidays ?? this.monthHolidays,
    );
  }
}
