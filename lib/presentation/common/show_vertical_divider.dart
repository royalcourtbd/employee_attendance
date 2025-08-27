import 'package:employee_attendance/core/config/employee_attendance_app_color.dart';
import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:flutter/material.dart';

class ShowVerticalDivider extends StatelessWidget {
  const ShowVerticalDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: EmployeeAttendanceAppColor.textColor.withValues(alpha: .1),
      width: 1,
      height: thirtyPx,
    );
  }
}
