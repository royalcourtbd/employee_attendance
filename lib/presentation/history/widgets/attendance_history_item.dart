import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/domain/entities/attendance.dart';
import 'package:employee_attendance/presentation/history/widgets/attendance_details.dart';
import 'package:employee_attendance/presentation/history/widgets/show_date_container.dart';
import 'package:flutter/material.dart';

class AttendanceHistoryItem extends StatelessWidget {
  const AttendanceHistoryItem({
    super.key,
    required this.theme,
    required this.attendance,
  });

  final ThemeData theme;
  final Attendance attendance;
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
            ShowDateContainer(
              date: attendance.checkInTime,
            ),
            gapW8,
            AttendanceDetails(
              theme: theme,
              attendance: attendance,
            ),
          ],
        ),
      ),
    );
  }
}
