import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/domain/entities/attendance.dart';
import 'package:employee_attendance/domain/usecases/attendance_usecases.dart';
import 'package:employee_attendance/presentation/history/presenter/history_page_ui_state.dart';
import 'package:employee_attendance/presentation/profile/presenter/profile_page_presenter.dart';

class HistoryPagePresenter extends BasePresenter<HistoryPageUiState> {
  final AttendanceUseCases _attendanceUseCases;
  final ProfilePagePresenter _profilePagePresenter;

  HistoryPagePresenter(this._attendanceUseCases, this._profilePagePresenter);

  final Obs<HistoryPageUiState> uiState = Obs(HistoryPageUiState.empty());
  HistoryPageUiState get currentUiState => uiState.value;

  @override
  void onInit() {
    initAttendanceStream();
    super.onInit();
  }

  void initAttendanceStream() {
    final userId = _profilePagePresenter.currentUiState.user?.id;
    if (userId != null) {
      initUserAttendanceStream(userId);
    } else {
      addUserMessage('User not found');
    }
  }

  void initUserAttendanceStream(String userId) async {
    toggleLoading(loading: true);
    _attendanceUseCases.getUserAttendanceStream(userId).listen(
      (List<Attendance> attendances) {
        uiState.value =
            currentUiState.copyWith(attendances: attendances, isLoading: false);
      },
      onError: (error) {
        addUserMessage('Attendance data load error: $error');
        toggleLoading(loading: false);
      },
    );
  }

  

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
