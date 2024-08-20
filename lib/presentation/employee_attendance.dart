// lib/presentation/employee_attendance.dart

import 'package:employee_attendance/core/config/themes.dart';
import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/presentable_widget_builder.dart';
import 'package:employee_attendance/presentation/authentication/presenter/auth_presenter.dart';
import 'package:employee_attendance/presentation/login/ui/login_page.dart';
import 'package:employee_attendance/presentation/main/ui/main_page.dart';
import 'package:employee_attendance/presentation/admin/ui/admin_dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeAttendance extends StatelessWidget {
  const EmployeeAttendance({super.key});

  static final GlobalKey _globalKey = GlobalKey();

  static BuildContext get globalContext =>
      Get.context ?? _globalKey.currentContext!;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: EmployeeAttendanceTheme.lightTheme,
      title: 'Employee Attendance',
      home: AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  AuthWrapper({super.key});

  final AuthPresenter _authPresenter = locate<AuthPresenter>();

  @override
  Widget build(BuildContext context) {
    return PresentableWidgetBuilder<AuthPresenter>(
      presenter: _authPresenter,
      onInit: () => _authPresenter.startUserStream(),
      builder: () {
        final user = _authPresenter.currentUiState.user;

        if (_authPresenter.currentUiState.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (user == null) {
          return LoginPage();
        }

        if (user.isEmployee) {
          return MainPage();
        } else {
          return const AdminDashboardPage();
        }
      },
    );
  }
}
