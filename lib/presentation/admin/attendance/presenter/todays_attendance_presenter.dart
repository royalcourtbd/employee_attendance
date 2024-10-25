// lib/presentation/admin/attendance/presenter/todays_attendance_presenter.dart

import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/data/models/employee_user_model.dart';
import 'package:employee_attendance/domain/entities/attendance_entity.dart';
import 'package:employee_attendance/domain/usecases/attendance_usecases.dart';
import 'package:employee_attendance/domain/usecases/get_all_employees_use_case.dart';
import 'package:employee_attendance/presentation/admin/attendance/presenter/todays_attendance_ui_state.dart';
import 'package:rxdart/rxdart.dart';

class TodaysAttendancePresenter extends BasePresenter<TodaysAttendanceUiState> {
  final AttendanceUseCases _attendanceUseCases;
  final GetAllEmployeesUseCase _getAllEmployeesUseCase;

  TodaysAttendancePresenter(
    this._attendanceUseCases,
    this._getAllEmployeesUseCase,
  );

  final Obs<TodaysAttendanceUiState> uiState =
      Obs(TodaysAttendanceUiState.empty());
  TodaysAttendanceUiState get currentUiState => uiState.value;

  @override
  void onInit() {
    super.onInit();
    _loadTodaysAttendance();
  }

  void _loadTodaysAttendance() {
    toggleLoading(loading: true);

    Rx.combineLatest2<List<AttendanceEntity>, List<EmployeeUserModel>,
            List<AttendanceWithEmployee>>(
        _attendanceUseCases.getTodaysAttendanceStream(),
        _getAllEmployeesUseCase.execute(), (attendances, employees) {
      return _combineAttendancesWithEmployees(attendances, employees);
    }).listen(
      (attendancesWithEmployee) {
        final summary = _calculateSummary(attendancesWithEmployee);
        uiState.value = currentUiState.copyWith(
          attendancesWithEmployee: attendancesWithEmployee,
          summary: summary,
          filteredAttendancesWithEmployee: attendancesWithEmployee,
          isLoading: false,
        );
      },
      onError: (error) {
        addUserMessage('Faild To load Today Attendance: $error');
        toggleLoading(loading: false);
      },
    );
  }

  List<AttendanceWithEmployee> _combineAttendancesWithEmployees(
      List<AttendanceEntity> attendances, List<EmployeeUserModel> employees) {
    return attendances.map((attendance) {
      final employee = employees.firstWhere(
          (emp) => emp.id == attendance.userId,
          orElse: () => const EmployeeUserModel(id: 'Unknown'));
      return AttendanceWithEmployee(attendance: attendance, employee: employee);
    }).toList();
  }

  AttendanceSummary _calculateSummary(
      List<AttendanceWithEmployee> attendances) {
    final totalPresent = attendances.length;
    final totalLate = attendances.where((a) => a.attendance.isLate).length;
    return AttendanceSummary(totalPresent: totalPresent, totalLate: totalLate);
  }

  void searchAttendances(String query) {
    if (query.isEmpty) {
      uiState.value = currentUiState.copyWith(
        filteredAttendancesWithEmployee: currentUiState.attendancesWithEmployee,
      );
    } else {
      final filteredList = currentUiState.attendancesWithEmployee.where((item) {
        return item.employee.name
                    ?.toLowerCase()
                    .contains(query.toLowerCase()) ==
                true ||
            item.employee.employeeId
                    ?.toLowerCase()
                    .contains(query.toLowerCase()) ==
                true;
      }).toList();
      uiState.value = currentUiState.copyWith(
        filteredAttendancesWithEmployee: filteredList,
      );
    }
  }

  void sortAttendances(SortCriteria criteria) {
    final sortedList = List<AttendanceWithEmployee>.from(
        currentUiState.filteredAttendancesWithEmployee);
    switch (criteria) {
      case SortCriteria.checkInTime:
        sortedList.sort((a, b) =>
            a.attendance.checkInTime.compareTo(b.attendance.checkInTime));
        break;
      case SortCriteria.name:
        sortedList.sort(
            (a, b) => (a.employee.name ?? '').compareTo(b.employee.name ?? ''));
        break;
    }
    uiState.value = currentUiState.copyWith(
      filteredAttendancesWithEmployee: sortedList,
      sortCriteria: criteria,
    );
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
