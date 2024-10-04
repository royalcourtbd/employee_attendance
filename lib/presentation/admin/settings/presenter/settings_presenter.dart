// lib/presentation/admin/settings/presenter/settings_presenter.dart ফাইলে

import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/domain/entities/office_settings.dart';
import 'package:employee_attendance/domain/usecases/attendance_usecases.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/presentation/admin/settings/presenter/settings_ui_state.dart';
import 'package:flutter/material.dart';

class SettingsPresenter extends BasePresenter<SettingsUiState> {
  final AttendanceUseCases _attendanceUseCases;

  SettingsPresenter(this._attendanceUseCases);

  final Obs<SettingsUiState> uiState = Obs(SettingsUiState.empty());
  SettingsUiState get currentUiState => uiState.value;

  final TextEditingController thresholdTextController = TextEditingController();
  final TextEditingController ssidTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _listenToOfficeSettings();
  }

  void _listenToOfficeSettings() {
    _attendanceUseCases.getOfficeSettingsStream().listen(
      (OfficeSettings settings) {
        uiState.value = SettingsUiState(
          isLoading: false,
          userMessage: '',
          startTime: TimeOfDay.fromDateTime(settings.startTime),
          endTime: TimeOfDay.fromDateTime(settings.endTime),
          lateThreshold: settings.lateThreshold,
          workDays: settings.workDays,
          ssid: settings.ssid,
        );
      },
      onError: (error) {
        addUserMessage('Problem With Update Setting $error');
      },
    );
  }

  void updateLateThreshold(
      {required BuildContext context, required VoidCallback navigatorPop}) {
    if (_isValidThreshold()) {
      final lateThreshold = int.parse(thresholdTextController.text);
      updateSettings(lateThreshold: lateThreshold);
      thresholdTextController.clear();
      navigatorPop();
    }
  }

  bool _isValidThreshold() {
    return thresholdTextController.text.isNotEmpty &&
        int.tryParse(thresholdTextController.text) != null &&
        int.parse(thresholdTextController.text) >= 0;
  }

  void updateWifiSSID(
      {required BuildContext context, required VoidCallback navigatorPop}) {
    if (ssidTextController.text.isNotEmpty) {
      updateSettings(ssid: ssidTextController.text);
      ssidTextController.clear();
      navigatorPop();
    }
  }

  void toggleWorkDay(String day) {
    final updatedWorkDays = [...currentUiState.workDays];
    if (updatedWorkDays.contains(day)) {
      updatedWorkDays.remove(day);
    } else {
      updatedWorkDays.add(day);
    }

    uiState.value = currentUiState.copyWith(workDays: updatedWorkDays);
  }

  Future<void> updateWorkingDays() async {
    await toggleLoading(loading: true);
    await updateSettings(workDays: currentUiState.workDays);
    await toggleLoading(loading: false);
  }

  // Days of the week
  final List<String> listOfDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  Future<void> updateSettings({
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    int? lateThreshold,
    List<String>? workDays,
    String? ssid,
  }) async {
    await toggleLoading(loading: true);
    try {
      final currentSettings =
          await _attendanceUseCases.getOfficeSettingsStream().first;

      final now = DateTime.now();

      final updatedSettings = OfficeSettings(
        startTime: startTime != null
            ? DateTime(
                now.year,
                now.month,
                now.day,
                startTime.hour,
                startTime.minute,
              )
            : currentSettings.startTime,
        endTime: endTime != null
            ? DateTime(
                now.year,
                now.month,
                now.day,
                endTime.hour,
                endTime.minute,
              )
            : currentSettings.endTime,
        lateThreshold: lateThreshold ?? currentSettings.lateThreshold,
        workDays: workDays ?? currentSettings.workDays,
        timeZone: currentSettings.timeZone,
        ssid: ssid ?? currentSettings.ssid, // Add this
      );

      await _attendanceUseCases.updateOfficeSettings(updatedSettings);
      await addUserMessage('Updated office settings successfully');
    } catch (e) {
      await addUserMessage('Failed to update office settings: $e');
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
