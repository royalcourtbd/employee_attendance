import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/utility/utility.dart';

import 'package:employee_attendance/domain/usecases/attendance_usecases.dart';
import 'package:employee_attendance/presentation/admin/attendance/presenter/todays_attendance_ui_state.dart';

class TodaysAttendancePresenter extends BasePresenter<TodaysAttendanceUiState> {
  final AttendanceUseCases _attendanceUseCases;

  TodaysAttendancePresenter(this._attendanceUseCases);

  final Obs<TodaysAttendanceUiState> uiState =
      Obs(TodaysAttendanceUiState.empty());
  TodaysAttendanceUiState get currentUiState => uiState.value;

  @override
  void onInit() {
    super.onInit();
    _loadTodaysAttendance();
  }

  Future<void> _loadTodaysAttendance() async {
    await toggleLoading(loading: true);
    try {
      final todaysAttendance = await _attendanceUseCases.getTodaysAttendance();
      uiState.value = currentUiState.copyWith(attendances: todaysAttendance);
    } catch (e) {
      await addUserMessage('আজকের অ্যাটেনডেন্স লোড করতে সমস্যা হয়েছে: $e');
    } finally {
      await toggleLoading(loading: false);
    }
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
