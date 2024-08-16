import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/presentation/history/widgets/attendance_details.dart';
import 'package:employee_attendance/presentation/history/widgets/show_date_container.dart';
import 'package:flutter/material.dart';

class AttendanceItem extends StatelessWidget {
  const AttendanceItem({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: tenPx),
      child: Container(
        padding: padding6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: radius10,
        ),
        child: Row(
          children: [
            const ShowDateContainer(),
            gapW8,
            AttendanceDetails(theme: theme)
          ],
        ),
      ),
    );
  }
}
