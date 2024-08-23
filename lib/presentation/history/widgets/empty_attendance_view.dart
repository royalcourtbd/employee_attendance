// lib/presentation/history/widgets/empty_attendance_view.dart

import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:employee_attendance/core/static/svg_path.dart';
import 'package:employee_attendance/core/static/ui_const.dart';

class EmptyAttendanceView extends StatelessWidget {
  const EmptyAttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            SvgPath.icDataNotFound,
            width: 150,
            height: 150,
          ),
          gapH30,
          Text(
            'No attendance data found',
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: sixteenPx,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
