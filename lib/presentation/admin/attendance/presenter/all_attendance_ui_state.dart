import 'package:employee_attendance/core/base/base_ui_state.dart';
import 'package:employee_attendance/domain/entities/all_attendance.dart';

class AllAttendanceUiState extends BaseUiState {
  final List<AllAttendance> allAttendances;
  final List<AllAttendance> filteredAttendances;
  final DateTime? startDate;
  final DateTime? endDate;
  final String searchQuery;
  final int currentPage;
  final int totalItems;

  const AllAttendanceUiState({
    required super.isLoading,
    required super.userMessage,
    required this.allAttendances,
    required this.filteredAttendances,
    this.startDate,
    this.endDate,
    this.searchQuery = '',
    this.currentPage = 1,
    this.totalItems = 0,
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
      currentPage: 1,
      totalItems: 0,
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
        currentPage,
        totalItems,
      ];

  AllAttendanceUiState copyWith({
    bool? isLoading,
    String? userMessage,
    List<AllAttendance>? allAttendances,
    List<AllAttendance>? filteredAttendances,
    DateTime? startDate,
    DateTime? endDate,
    String? searchQuery,
    int? currentPage,
    int? totalItems,
  }) {
    return AllAttendanceUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      allAttendances: allAttendances ?? this.allAttendances,
      filteredAttendances: filteredAttendances ?? this.filteredAttendances,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      searchQuery: searchQuery ?? this.searchQuery,
      currentPage: currentPage ?? this.currentPage,
      totalItems: totalItems ?? this.totalItems,
    );
  }
}
