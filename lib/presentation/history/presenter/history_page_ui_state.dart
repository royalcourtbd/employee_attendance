// lib/presentation/history/presenter/history_page_ui_state.dart ফাইলে

import 'package:employee_attendance/core/base/base_ui_state.dart';
import 'package:employee_attendance/domain/entities/attendance.dart';
import 'package:employee_attendance/domain/service/holiday_service.dart';

class HistoryPageUiState extends BaseUiState {
  const HistoryPageUiState({
    required super.isLoading,
    required super.userMessage,
    required this.attendances,
    required this.selectedMonth,
    required this.monthHolidays,
  });

  factory HistoryPageUiState.empty() {
    return HistoryPageUiState(
      isLoading: false,
      userMessage: '',
      attendances: const [],
      selectedMonth: DateTime.now(),
      monthHolidays: const [],
    );
  }

  final List<Attendance> attendances;
  final DateTime selectedMonth;
  final List<Holiday> monthHolidays;

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        attendances,
        selectedMonth,
        monthHolidays,
      ];

  HistoryPageUiState copyWith({
    bool? isLoading,
    String? userMessage,
    List<Attendance>? attendances,
    DateTime? selectedMonth,
    List<Holiday>? monthHolidays,
  }) {
    return HistoryPageUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      attendances: attendances ?? this.attendances,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      monthHolidays: monthHolidays ?? this.monthHolidays,
    );
  }
}
