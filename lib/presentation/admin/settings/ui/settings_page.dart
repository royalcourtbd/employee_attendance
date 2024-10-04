import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/presentable_widget_builder.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/presentation/admin/settings/presenter/settings_presenter.dart';
import 'package:employee_attendance/presentation/admin/settings/widgets/settings_item.dart';
import 'package:employee_attendance/presentation/admin/settings/widgets/update_late_threshold_popup.dart';
import 'package:employee_attendance/presentation/home/presenter/home_presenter.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final SettingsPresenter _settingsPresenter = locate<SettingsPresenter>();

  @override
  Widget build(BuildContext context) {
    return PresentableWidgetBuilder(
      presenter: _settingsPresenter,
      builder: () {
        final uiState = _settingsPresenter.currentUiState;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
          ),
          body: ListView(
            children: [
              SettingsItem(
                title: 'Start Time',
                value: uiState.startTime.format(context),
                onTap: () => updateTime(
                    context: context,
                    timeType: 'startTime',
                    settingsPresenter: _settingsPresenter),
              ),
              SettingsItem(
                title: 'End Time',
                value: uiState.endTime.format(context),
                onTap: () => updateTime(
                    context: context,
                    timeType: 'endTime',
                    settingsPresenter: _settingsPresenter),
              ),
              SettingsItem(
                title: 'Late Threshold',
                value: '${uiState.lateThreshold} minutes',
                onTap: () => UpdateLateThresholdPopup.show(
                  context: context,
                  updateThreshold: () => _settingsPresenter.updateLateThreshold(
                    context: context,
                    navigatorPop: () => context.navigatorPop(),
                  ),
                ),
              ),
              SettingsItem(
                title: 'Work Days',
                value: uiState.workDays.join(', '),
                onTap: () => _settingsPresenter.updateWorkDays(context),
              ),
              SettingsItem(
                title: 'SSID',
                value: uiState.ssid,
                onTap: () => _settingsPresenter.updateSSID(context),
              ),
              TextButton(
                  onPressed: () => locate<HomePresenter>().initializeSettings(),
                  child: const Text('Save')),
            ],
          ),
        );
      },
    );
  }
}