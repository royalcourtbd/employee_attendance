// lib/presentation/employee_attendance.dart

import 'package:employee_attendance/core/config/themes.dart';
import 'package:employee_attendance/core/services/app_bootstrap.dart';
import 'package:employee_attendance/presentation/admin/dashboard/ui/admin_dashboard_page.dart';
import 'package:employee_attendance/presentation/login/ui/login_page.dart';
import 'package:employee_attendance/presentation/main/ui/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeAttendance extends StatelessWidget {
  const EmployeeAttendance({
    super.key,
    required this.initialDestination,
  });

  final AppDestination initialDestination;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext? get globalContextOrNull =>
      navigatorKey.currentContext ?? Get.context;

  static BuildContext get globalContext =>
      globalContextOrNull ??
      (throw StateError('Application context is not available yet'));

  Widget get _homePage {
    switch (initialDestination) {
      case AppDestination.login:
        return LoginPage();
      case AppDestination.adminDashboard:
        return AdminDashboardPage();
      case AppDestination.employeeHome:
        return MainPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: EmployeeAttendanceTheme.lightTheme,
      title: 'Employee Attendance',
      home: _homePage,
    );
  }
}
