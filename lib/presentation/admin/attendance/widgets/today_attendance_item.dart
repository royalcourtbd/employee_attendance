// lib/presentation/admin/attendance/ui/todays_attendance_page.dart

import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/presentation/admin/attendance/presenter/todays_attendance_ui_state.dart';
import 'package:employee_attendance/presentation/common/profile_pic_widget.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodayAttendanceItem extends StatelessWidget {
  const TodayAttendanceItem(
      {super.key, required this.item, required this.theme});

  final AttendanceWithEmployee item;

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: tenPx, vertical: fivePx),
      child: Container(
        padding: padding10,
        decoration: BoxDecoration(
          color: theme.cardColor.withOpacity(0.5),
          borderRadius: radius10,
        ),
        child: Row(
          children: [
            ProfilePicWidget(
                theme: theme, networkImageURL: item.employee.image ?? ''),
            gapW10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.employee.name ?? '',
                    style: GoogleFonts.koHo(
                      fontWeight: FontWeight.w600,
                      fontSize: sixteenPx,
                    )),
                Text(
                  '${getFormattedTime(item.attendance.checkInTime)} • ${getFormattedTime(item.attendance.checkOutTime)}',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: thirteenPx,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                Text(
                  'Hours',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: thirteenPx,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  getFormattedDuration(item.attendance.workDuration),
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: thirteenPx,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
