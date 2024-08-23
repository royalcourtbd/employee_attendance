import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/services/firebase_service.dart';
import 'package:employee_attendance/domain/entities/attendance.dart';
import 'package:employee_attendance/domain/usecases/attendance_usecases.dart';
import 'package:employee_attendance/domain/usecases/get_greeting_usecase.dart';
import 'package:employee_attendance/presentation/home/presenter/home_page_ui_state.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePresenter extends BasePresenter<HomePageUiState> {
  final GetGreetingUseCase _getGreetingUseCase;
  final AttendanceUseCases _attendanceUseCases;

  final FirebaseService _firebaseService;

  HomePresenter(this._getGreetingUseCase, this._attendanceUseCases,
      this._firebaseService);

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
    initTodayAttendanceStream();
    _updateButtonState();
    _initSettingsStream();
    _listenToAuthStateChanges();
  }

  @override
  void onClose() {
    _timer?.cancel();
    _attendanceSubscription?.cancel();
    _settingsSubscription?.cancel();
    super.onClose();
  }

  void reset() {
    onClose();
    uiState.value = HomePageUiState.empty();
    onInit();
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

  String getFormattedTime(DateTime? time) {
    return time != null ? DateFormat('hh:mm a').format(time) : '--:--';
  }

  String getFormattedDuration(Duration? duration) {
    if (duration == null) return '--:--';
    return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
  }

  void resetAttendance() {
    uiState.value = currentUiState.copyWith(
      checkInTime: null,
      checkOutTime: null,
      workDuration: null,
    );
  }

  String? getCurrentUserId() {
    return _firebaseService.auth.currentUser?.uid;
  }

  // Add this method
  void _listenToAuthStateChanges() {
    _firebaseService.auth.authStateChanges().listen((user) {
      if (user == null) {
        // User logged out, reset the state
        resetState();
      } else {
        // User logged in, reinitialize streams
        initTodayAttendanceStream();
        _updateButtonState();
      }
    });
  }

  // Add this method
  void resetState() {
    uiState.value = HomePageUiState.empty();
    _attendanceSubscription?.cancel();
    _settingsSubscription?.cancel();
  }

  void initTodayAttendanceStream() {
    final String? userId = getCurrentUserId();
    if (userId == null) return;

    _attendanceSubscription?.cancel();
    _attendanceSubscription =
        _attendanceUseCases.getTodayAttendanceStream(userId).listen(
      (attendance) {
        uiState.value = currentUiState.copyWith(
          checkInTime: attendance?.checkInTime,
          checkOutTime: attendance?.checkOutTime,
          workDuration: attendance?.workDuration,
          isCheckedIn: attendance != null && attendance.checkOutTime == null,
        );
        _updateButtonState();
      },
    );
  }

  Future<void> _updateButtonState() async {
    final String? userId = getCurrentUserId();
    if (userId == null) return;

    final canCheckIn = await _attendanceUseCases.canCheckInToday(userId);
    final canCheckOut = await _attendanceUseCases.canCheckOutToday(userId);

    uiState.value = currentUiState.copyWith(
      canCheckIn: canCheckIn,
      canCheckOut: canCheckOut,
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
      // Current time
      DateTime now = DateTime.now();

      // Time after 9 hours
      DateTime endTime = now.add(const Duration(hours: 9));

      await _firestore.collection('settings').doc('office').set({
        'startTime': Timestamp.fromDate(now), //  Current time
        'endTime': Timestamp.fromDate(endTime), // Time after 9 hours
        'lateThreshold': 10, // 10 minutes
        'workDays': ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday'],
        'timeZone': 'Asia/Dhaka',
      });

      debugPrint('Office settings added successfully');
    } catch (e) {
      debugPrint('There was an issue adding the settings.: $e');
    }
  }

  Future<void> handleAttendanceAction() async {
    final String? userId = getCurrentUserId();
    if (userId == null) return;

    if (currentUiState.canCheckIn) {
      await _attendanceUseCases.checkIn(userId);
    } else if (currentUiState.canCheckOut) {
      await _attendanceUseCases.checkOut(userId);
    }
    await _updateButtonState();
  }

  Color getCheckButtonColor(ThemeData theme) {
    if (currentUiState.canCheckIn) {
      return theme.primaryColor;
    } else if (currentUiState.canCheckOut) {
      return theme.colorScheme.error;
    } else {
      return theme.colorScheme.secondary;
    }
  }

  String getCheckButtonText() {
    if (currentUiState.canCheckIn) {
      return 'Check In';
    } else if (currentUiState.canCheckOut) {
      return 'Check Out';
    } else {
      return 'Done for today!';
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
