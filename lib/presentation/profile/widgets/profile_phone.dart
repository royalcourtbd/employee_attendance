import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:flutter/material.dart';

class ProfileId extends StatelessWidget {
  final ThemeData theme;
  final String employeeId;

  const ProfileId({
    super.key,
    required this.theme,
    required this.employeeId,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      employeeId,
      style: theme.textTheme.bodyMedium!.copyWith(
        fontSize: fifteenPx,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }
}
