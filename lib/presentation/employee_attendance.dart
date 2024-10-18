// lib/presentation/employee_attendance.dart

import 'package:employee_attendance/core/config/themes.dart';
import 'package:employee_attendance/presentation/authentication/ui/auth_wrapper_page.dart';
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
      home: AuthWrapperPage(),
    );
  }
}
