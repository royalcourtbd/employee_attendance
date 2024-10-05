import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/presentable_widget_builder.dart';
import 'package:employee_attendance/presentation/admin/attendance/presenter/todays_attendance_presenter.dart';
import 'package:employee_attendance/presentation/history/widgets/attendance_item.dart';
import 'package:flutter/material.dart';

class TodaysAttendancePage extends StatelessWidget {
  TodaysAttendancePage({super.key});

  final TodaysAttendancePresenter _todaysAttendancePresenter =
      locate<TodaysAttendancePresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: _todaysAttendancePresenter,
      builder: () {
        final uiState = _todaysAttendancePresenter.currentUiState;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Today\'s Attendance'),
          ),
          body: uiState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : uiState.attendances.isEmpty
                  ? const Center(child: Text('No attendance found'))
                  : ListView.builder(
                      itemCount: uiState.attendances.length,
                      itemBuilder: (context, index) {
                        final attendance = uiState.attendances[index];
                        return AttendanceItem(
                          theme: theme,
                          attendance: attendance,
                        );
                      },
                    ),
        );
      },
    );
  }
}
