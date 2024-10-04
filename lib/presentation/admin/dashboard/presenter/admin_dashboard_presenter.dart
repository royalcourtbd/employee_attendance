import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/domain/usecases/logout_usecase.dart';
import 'package:employee_attendance/presentation/admin/dashboard/presenter/admin_dashboard_ui_state.dart';
import 'package:employee_attendance/presentation/admin/employee/ui/employees_page.dart';
import 'package:employee_attendance/presentation/admin/settings/ui/settings_page.dart';
import 'package:employee_attendance/presentation/home/presenter/home_presenter.dart';

import 'package:flutter/material.dart';

class AdminDashboardPresenter extends BasePresenter<AdminDashboardUiState> {
  final LogoutUseCase _logoutUseCase;

  AdminDashboardPresenter(this._logoutUseCase);

  final Obs<AdminDashboardUiState> uiState = Obs(AdminDashboardUiState.empty());
  AdminDashboardUiState get currentUiState => uiState.value;

  late final HomePresenter _homePresenter = locate<HomePresenter>();

  void navigateToEmployeesPage(BuildContext context) {
    context.navigatorPush(EmployeesPage());
  }

  void navigateToSettingsPage(BuildContext context) {
    context.navigatorPush(SettingsPage());
  }

  Future<void> logout() async {
    await toggleLoading(loading: true);
    try {
      _homePresenter.resetAttendance();
      await _logoutUseCase.execute();
      uiState.value = AdminDashboardUiState.empty();
      showMessage(message: 'Logged out successfully');
    } catch (e) {
      debugPrint('Error logging out: $e');
      await addUserMessage('Error logging out');
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
