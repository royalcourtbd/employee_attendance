import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/presentation/admin/attendance/presenter/view_attendance_ui_state.dart';

class ViewAttendancePresenter extends BasePresenter<ViewAttendanceUiState> {
  final Obs<ViewAttendanceUiState> uiState = Obs(ViewAttendanceUiState.empty());
  ViewAttendanceUiState get currentUiState => uiState.value;

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
