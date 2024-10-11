// lib/presentation/admin/attendance/ui/todays_attendance_page.dart

import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/font_family.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/presentation/common/profile_pic_widget.dart';
import 'package:flutter/material.dart';

class AttendanceListItem extends StatelessWidget {
  const AttendanceListItem({
    super.key,
    required this.theme,
    this.employeeNetworkImageURL,
    this.checkInTime,
    this.checkOutTime,
    this.workDuration,
    this.date,
    this.name,
  });

  final String? name;
  final String? employeeNetworkImageURL;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final Duration? workDuration;
  final DateTime? date;
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
              theme: theme,
              networkImageURL: employeeNetworkImageURL ?? '',
            ),
            gapW10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? '',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: sixteenPx,
                    fontFamily: FontFamily.koho,
                  ),
                ),
                if (date != null || checkInTime != null || checkOutTime != null)
                  Text(
                    [
                      if (date != null) getFormattedDate(date),
                      getFormattedTime(checkInTime),
                      getFormattedTime(checkOutTime),
                    ].where((element) => element.isNotEmpty).join(' • '),
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
                  getFormattedDuration(workDuration),
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
