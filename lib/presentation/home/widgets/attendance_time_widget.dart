import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:flutter/material.dart';

class AttendanceTimeWidget extends StatelessWidget {
  final String iconPath;
  final String? time;
  final String label;

  const AttendanceTimeWidget({
    super.key,
    required this.iconPath,
    this.time,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: padding15,
        child: Column(
          children: [
            Image.asset(
              iconPath,
              color: theme.primaryColor,
              width: thirtyPx,
            ),
            gapH10,
            Text(
              time ?? '--:--',
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: sixteenPx,
                fontWeight: FontWeight.bold,
              ),
            ),
            gapH10,
            Text(
              label,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: thirteenPx,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
