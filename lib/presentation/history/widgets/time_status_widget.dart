import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:flutter/material.dart';

class TimeStatusWidget extends StatelessWidget {
  final String time;
  final String status;
  final ThemeData theme;

  const TimeStatusWidget({
    super.key,
    required this.theme,
    required this.time,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: padding8,
        child: Column(
          children: [
            Text(
              time,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: thirteenPx,
                fontWeight: FontWeight.w600,
              ),
            ),
            gapH3,
            Text(
              status,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: thirteenPx,
                color:
                    theme.textTheme.bodyMedium!.color!.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
