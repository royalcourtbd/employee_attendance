import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/domain/config/pagination_config.dart';
import 'package:employee_attendance/domain/entities/all_attendance.dart';
import 'package:employee_attendance/domain/usecases/get_all_attendance_usecase.dart';
import 'package:employee_attendance/presentation/admin/attendance/presenter/all_attendance_ui_state.dart';
import 'package:flutter/material.dart';

class AllAttendancePresenter extends BasePresenter<AllAttendanceUiState> {
  final GetAllAttendanceUseCase _attendanceUseCases;

  AllAttendancePresenter(this._attendanceUseCases);

  final Obs<AllAttendanceUiState> uiState = Obs(AllAttendanceUiState.empty());
  AllAttendanceUiState get currentUiState => uiState.value;

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadAllAttendances();
  }

  void initPage() {
    _loadAllAttendances();
  }

  void _loadAllAttendances() {
    toggleLoading(loading: true);
    uiState.value = uiState.value.copyWith(
      allAttendances: [],
      filteredAttendances: [],
      totalItems: 0,
      currentPage: 1,
    );

    _attendanceUseCases.getAllAttendancesStream().listen(
      (List<AllAttendance> allAttendances) {
        allAttendances.sort((a, b) =>
            b.attendance.checkInTime.compareTo(a.attendance.checkInTime));

        uiState.value = currentUiState.copyWith(
          allAttendances: allAttendances,
        );
        _applyFiltersAndPagination();
      },
      onError: (error) {
        addUserMessage('অ্যাটেন্ডেন্স তথ্য লোড করতে ব্যর্থ হয়েছে: $error');
        toggleLoading(loading: false);
      },
    );
  }

  void _applyFiltersAndPagination() {
    List<AllAttendance> filtered = currentUiState.allAttendances;

    if (currentUiState.searchQuery.isNotEmpty) {
      filtered = filtered.where((item) {
        final nameMatch = item.employee.name
                ?.toLowerCase()
                .contains(currentUiState.searchQuery.toLowerCase()) ??
            false;
        final idMatch = item.employee.employeeId
                ?.toLowerCase()
                .contains(currentUiState.searchQuery.toLowerCase()) ??
            false;
        return nameMatch || idMatch;
      }).toList();
    }

    if (currentUiState.startDate != null) {
      filtered = filtered
          .where((item) =>
              item.attendance.checkInTime.isAfter(currentUiState.startDate!))
          .toList();
    }

    if (currentUiState.endDate != null) {
      filtered = filtered
          .where((item) => item.attendance.checkInTime
              .isBefore(currentUiState.endDate!.add(const Duration(days: 1))))
          .toList();
    }

    final int endIndex =
        (currentUiState.currentPage * PaginationConfig.pageSize)
            .clamp(0, filtered.length);
    final paginatedList = filtered.sublist(0, endIndex);

    uiState.value = currentUiState.copyWith(
      filteredAttendances: paginatedList,
      totalItems: filtered.length,
      isLoading: false,
    );
  }

  void filterAttendances(
      {String? searchQuery, DateTime? startDate, DateTime? endDate}) {
    uiState.value = currentUiState.copyWith(
      searchQuery: searchQuery ?? currentUiState.searchQuery,
      startDate: startDate ?? currentUiState.startDate,
      endDate: endDate ?? currentUiState.endDate,
      currentPage: 1,
    );
    _applyFiltersAndPagination();
  }

  void loadMoreItems() {
    if (currentUiState.filteredAttendances.length < currentUiState.totalItems) {
      uiState.value = currentUiState.copyWith(
        currentPage: currentUiState.currentPage + 1,
      );
      _applyFiltersAndPagination();
    }
  }

  void resetFilters() {
    searchController.clear();
    uiState.value = AllAttendanceUiState.empty();
    _applyFiltersAndPagination();
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
    return showMessage(message: currentUiState.userMessage);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
