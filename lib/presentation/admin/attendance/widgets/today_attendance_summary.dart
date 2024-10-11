import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/presentation/admin/attendance/presenter/todays_attendance_presenter.dart';
import 'package:employee_attendance/presentation/admin/attendance/widgets/today_attendance_summary_item.dart';
import 'package:flutter/material.dart';

class TodayAttendanceSummary extends StatelessWidget {
  const TodayAttendanceSummary(
      {super.key,
      required this.theme,
      required this.todaysAttendancePresenter});
  final ThemeData theme;

  final TodaysAttendancePresenter todaysAttendancePresenter;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding15,
      color: theme.primaryColor.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TodayAttendanceSummaryItem(
            label: 'Total Present',
            value: todaysAttendancePresenter.currentUiState.summary.totalPresent
                .toString(),
            theme: theme,
          ),
          TodayAttendanceSummaryItem(
            label: 'Total Late',
            value: todaysAttendancePresenter.currentUiState.summary.totalLate
                .toString(),
            theme: theme,
          )
        ],
      ),
    );
  }
}
