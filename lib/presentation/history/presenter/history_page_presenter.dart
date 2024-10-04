// lib/presentation/history/presenter/history_page_presenter.dart ফাইলে

import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/domain/entities/attendance.dart';
import 'package:employee_attendance/domain/service/holiday_service.dart';
import 'package:employee_attendance/domain/usecases/attendance_usecases.dart';
import 'package:employee_attendance/presentation/history/presenter/history_page_ui_state.dart';
import 'package:employee_attendance/presentation/profile/presenter/profile_page_presenter.dart';
import 'package:rxdart/rxdart.dart';

class HistoryPagePresenter extends BasePresenter<HistoryPageUiState> {
  final AttendanceUseCases _attendanceUseCases;
  final ProfilePagePresenter _profilePagePresenter;
  final HolidayService _holidayService;

  HistoryPagePresenter(this._attendanceUseCases, this._profilePagePresenter,
      this._holidayService);

  final Obs<HistoryPageUiState> uiState = Obs(HistoryPageUiState.empty());
  HistoryPageUiState get currentUiState => uiState.value;

  final BehaviorSubject<DateTime> _selectedMonthSubject =
      BehaviorSubject.seeded(DateTime.now());

  @override
  void onInit() {
    initAttendanceStream();
    super.onInit();
  }

  void initAttendanceStream() {
    final userId = _profilePagePresenter.currentUiState.employee?.id;
    if (userId != null) {
      initUserAttendanceStream(userId);
    } else {
      addUserMessage('ইউজার পাওয়া যায়নি');
    }
  }

  void initUserAttendanceStream(String userId) {
    toggleLoading(loading: true);

    Rx.combineLatest2<List<Attendance>, DateTime, List<Attendance>>(
        _attendanceUseCases.getUserAttendanceStream(userId),
        _selectedMonthSubject.stream, (attendances, selectedMonth) {
      return attendances
          .where((attendance) =>
              attendance.checkInTime.year == selectedMonth.year &&
              attendance.checkInTime.month == selectedMonth.month)
          .toList();
    }).listen(
      (filteredAttendances) {
        List<Holiday> monthHolidays = _holidayService.getHolidaysForMonth(
            _selectedMonthSubject.value.year,
            _selectedMonthSubject.value.month);
        uiState.value = currentUiState.copyWith(
          filteredAttendances: filteredAttendances,
          monthHolidays: monthHolidays,
          selectedMonth: _selectedMonthSubject.value,
          isLoading: false,
        );
      },
      onError: (error) {
        addUserMessage('অ্যাটেনডেন্স ডেটা লোড করতে সমস্যা হয়েছে: $error');
        toggleLoading(loading: false);
      },
    );
  }

  void updateSelectedMonth(DateTime selectedMonth) {
    _selectedMonthSubject.add(selectedMonth);
  }

  bool isHoliday(DateTime date) {
    return _holidayService.isHoliday(date) || date.weekday == DateTime.friday;
  }

  String? getHolidayReason(DateTime date) {
    return _holidayService.getHolidayReason(date) ??
        (date.weekday == DateTime.friday ? "সাপ্তাহিক ছুটি" : null);
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    updateSelectedMonth(selectedDay);
    String? reason = getHolidayReason(selectedDay);
    if (reason != null) {
      addUserMessage(reason);
      showMessage(message: currentUiState.userMessage);
    }
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }

  @override
  void onClose() {
    _selectedMonthSubject.close();
    super.onClose();
  }
}
