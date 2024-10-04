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

  final TextEditingController thresholdController = TextEditingController();

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
          ssid: settings.ssid, // Add this
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
      final lateThreshold = int.parse(thresholdController.text);
      updateSettings(lateThreshold: lateThreshold);
      thresholdController.clear();
      navigatorPop();
    }
  }

  bool _isValidThreshold() {
    return thresholdController.text.isNotEmpty &&
        int.tryParse(thresholdController.text) != null &&
        int.parse(thresholdController.text) >= 0;
  }

  Future<void> updateWorkDays(BuildContext context) async {
    final List<String> allDays = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
    ];
    final List<String> selectedDays = List.from(currentUiState.workDays);

    final List<String>? result = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Work Days'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: ListBody(
                  children: allDays.map((String day) {
                    return CheckboxListTile(
                      title: Text(day),
                      value: selectedDays.contains(day),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedDays.add(day);
                          } else {
                            selectedDays.remove(day);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => context.navigatorPop(),
            ),
            TextButton(
              child: const Text('Done'),
              onPressed: () => context.navigatorPop(),
            ),
          ],
        );
      },
    );

    if (result != null) {
      await updateSettings(workDays: result);
    }
  }

  Future<void> updateSSID(BuildContext context) async {
    String newSSID = '';
    final String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Update SSID'),
        content: TextField(
          decoration: const InputDecoration(
            hintText: "Write new SSID here",
          ),
          autofocus: true,
          onChanged: (value) {
            newSSID = value;
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => context.navigatorPop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (newSSID.isNotEmpty) {
                context.navigatorPop();
              }
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );

    if (result != null) {
      await updateSettings(ssid: result);
    }
  }

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
      await addUserMessage('অফিস সেটিংস আপডেট করতে ব্যর্থ: $e');
    } finally {
      await toggleLoading(loading: false);
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
