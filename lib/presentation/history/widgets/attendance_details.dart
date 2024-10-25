import 'package:employee_attendance/core/config/employee_attendance_app_color.dart';
import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/domain/entities/attendance_entity.dart';
import 'package:employee_attendance/presentation/common/show_vertical_divider.dart';
import 'package:employee_attendance/presentation/history/widgets/time_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceDetails extends StatelessWidget {
  const AttendanceDetails({
    super.key,
    required this.theme,
    required this.attendance,
  });

  final ThemeData theme;
  final AttendanceEntity attendance;

  String _formatTime(DateTime? time) {
    return time != null ? DateFormat('hh:mm a').format(time) : '--:--';
  }

  String _formatDuration(Duration? duration) {
    if (duration == null) return '--:--';
    return '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TimeStatusWidget(
                  theme: theme,
                  time: _formatTime(attendance.checkInTime),
                  status: 'Check In'),
              const ShowVerticalDivider(),
              TimeStatusWidget(
                  theme: theme,
                  time: _formatTime(attendance.checkOutTime),
                  status: 'Check Out'),
              const ShowVerticalDivider(),
              TimeStatusWidget(
                  theme: theme,
                  time: _formatDuration(attendance.workDuration),
                  status: 'Total Hrs'),
            ],
          ),
          Divider(
            height: sevenPx,
            color: EmployeeAttendanceAppColor.textColor.withOpacity(0.1),
          ),
          Text(
            'Eastern Banabithi Shopping Complex ~ South Banasree',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: thirteenPx,
              color: theme.textTheme.bodyMedium!.color!.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
