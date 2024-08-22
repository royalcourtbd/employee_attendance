import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/domain/entities/attendance.dart';
import 'package:employee_attendance/domain/usecases/attendance_usecases.dart';

import 'package:employee_attendance/domain/usecases/get_greeting_usecase.dart';
import 'package:employee_attendance/presentation/home/presenter/home_page_ui_state.dart';
import 'package:employee_attendance/presentation/profile/presenter/profile_page_presenter.dart';

class HomePresenter extends BasePresenter<HomePageUiState> {
  final GetGreetingUseCase _getGreetingUseCase;
  final AttendanceUseCases _attendanceUseCases;
  final ProfilePagePresenter _profilePagePresenter;

  HomePresenter(this._getGreetingUseCase, this._attendanceUseCases,
      this._profilePagePresenter);

  final Obs<HomePageUiState> uiState = Obs(HomePageUiState.empty());
  HomePageUiState get currentUiState => uiState.value;

  Timer? _timer;
  StreamSubscription<Attendance?>? _attendanceSubscription;
  StreamSubscription<Map<String, dynamic>>? _settingsSubscription;

  @override
  void onInit() {
    super.onInit();
    getGreeting();
    startClock();
    _initAttendanceStream();
    _initSettingsStream();
  }

  @override
  void onClose() {
    _timer?.cancel();
    _attendanceSubscription?.cancel();
    _settingsSubscription?.cancel();
    super.onClose();
  }

  void startClock() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateCurrentTime();
    });
  }

  void updateCurrentTime() {
    uiState.value = currentUiState.copyWith(nowTimeIsIt: DateTime.now());
  }

  Future<void> getGreeting() async {
    final greeting = _getGreetingUseCase.execute();
    uiState.value = currentUiState.copyWith(greetingMessage: greeting);
  }

  String? getCurrentUserId() {
    return _profilePagePresenter.currentUiState.user?.id;
  }

  void _initAttendanceStream() {
    final String? userId =
        getCurrentUserId(); // এটি আপনার বর্তমান ইউজারের ID হওয়া উচিত
    _attendanceSubscription =
        _attendanceUseCases.getAttendanceStream(userId!).listen(
      (attendance) {
        uiState.value = currentUiState.copyWith(
          checkInTime: attendance?.checkInTime,
          checkOutTime: attendance?.checkOutTime,
          workDuration: attendance?.workDuration,
          isCheckedIn: attendance != null && attendance.checkOutTime == null,
        );
      },
    );
  }

  void _initSettingsStream() {
    _settingsSubscription =
        _attendanceUseCases.getOfficeSettingsStream().listen(
      (settings) {
        uiState.value = currentUiState.copyWith(
          officeStartTime: settings['startTime']?.toDate(),
          officeEndTime: settings['endTime']?.toDate(),
        );
      },
    );
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> initializeSettings() async {
    try {
      // বর্তমান সময়
      DateTime now = DateTime.now();

      // ৯ ঘণ্টা পরের সময়
      DateTime endTime = now.add(const Duration(hours: 9));

      await _firestore.collection('settings').doc('office').set({
        'startTime': Timestamp.fromDate(now), // বর্তমান সময়
        'endTime': Timestamp.fromDate(endTime), // ৯ ঘণ্টা পরের সময়
        'lateThreshold': 10, // ১০ মিনিট
        'workDays': ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday'],
        'timeZone': 'Asia/Dhaka',
      });

      print('অফিস সেটিংস সফলভাবে যোগ করা হয়েছে।');
    } catch (e) {
      print('সেটিংস যোগ করতে সমস্যা হয়েছে: $e');
    }
  }

  Future<void> handleAttendanceAction() async {
    final String? userId =
        getCurrentUserId(); // এটি আপনার বর্তমান ইউজারের ID হওয়া উচিত
    if (currentUiState.isCheckedIn) {
      await _attendanceUseCases.checkOut(userId!);
    } else {
      await _attendanceUseCases.checkIn(userId!);
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
}
