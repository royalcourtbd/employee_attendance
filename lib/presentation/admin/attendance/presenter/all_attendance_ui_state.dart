import 'package:employee_attendance/core/base/base_ui_state.dart';
import 'package:employee_attendance/domain/entities/all_attendance.dart';

class AllAttendanceUiState extends BaseUiState {
  final List<AllAttendance> allAttendances;
  final List<AllAttendance> filteredAttendances;
  final DateTime? startDate;
  final DateTime? endDate;
  final String searchQuery;

  const AllAttendanceUiState({
    required super.isLoading,
    required super.userMessage,
    required this.allAttendances,
    required this.filteredAttendances,
    this.startDate,
    this.endDate,
    this.searchQuery = '',
  });

  factory AllAttendanceUiState.empty() {
    return const AllAttendanceUiState(
      isLoading: false,
      userMessage: '',
      allAttendances: [],
      filteredAttendances: [],
      startDate: null,
      endDate: null,
      searchQuery: '',
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        allAttendances,
        filteredAttendances,
        startDate,
        endDate,
        searchQuery,
      ];

  AllAttendanceUiState copyWith({
    bool? isLoading,
    String? userMessage,
    List<AllAttendance>? allAttendances,
    List<AllAttendance>? filteredAttendances,
    DateTime? startDate,
    DateTime? endDate,
    String? searchQuery,
  }) {
    return AllAttendanceUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      allAttendances: allAttendances ?? this.allAttendances,
      filteredAttendances: filteredAttendances ?? this.filteredAttendances,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}