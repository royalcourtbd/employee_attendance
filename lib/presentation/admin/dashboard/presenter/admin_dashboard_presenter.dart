import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/presentation/admin/dashboard/presenter/admin_dashboard_ui_state.dart';
import 'package:employee_attendance/presentation/admin/employee/ui/employees_page.dart';
import 'package:employee_attendance/presentation/admin/settings/ui/settings_page.dart';

import 'package:flutter/material.dart';

class AdminDashboardPresenter extends BasePresenter<AdminDashboardUiState> {
  final Obs<AdminDashboardUiState> uiState = Obs(AdminDashboardUiState.empty());
  AdminDashboardUiState get currentUiState => uiState.value;

  void navigateToEmployeesPage(BuildContext context) {
    context.navigatorPush(EmployeesPage());
  }

  void navigateToSettingsPage(BuildContext context) {
    context.navigatorPush(SettingsPage());
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
