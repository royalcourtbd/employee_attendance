import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:flutter/material.dart';

class Copyright extends StatelessWidget {
  final ThemeData theme;

  const Copyright({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Copyright @ 2024 Employee Attendance.\nAll rights reserved.',
      textAlign: TextAlign.center,
      style: theme.textTheme.bodyMedium!.copyWith(
        fontSize: fourteenPx,
        color: theme.textTheme.bodyMedium!.color!.withOpacity(0.5),
      ),
    );
  }
}
