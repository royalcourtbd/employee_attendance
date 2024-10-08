import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/presentable_widget_builder.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/presentation/admin/attendance/presenter/todays_attendance_presenter.dart';
import 'package:employee_attendance/presentation/admin/attendance/widgets/show_sort_option_popup.dart';
import 'package:employee_attendance/presentation/admin/attendance/widgets/today_attendance_item.dart';
import 'package:employee_attendance/presentation/admin/attendance/widgets/today_attendance_summary.dart';
import 'package:employee_attendance/presentation/login/widgets/custom_text_field.dart';
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
          body: Column(
            children: [
              TodayAttendanceSummary(
                theme: theme,
                todaysAttendancePresenter: _todaysAttendancePresenter,
              ),
              Padding(
                padding: padding10,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        theme: theme,
                        hintText: 'Search by name or ID',
                        onChanged: (value) =>
                            _todaysAttendancePresenter.searchAttendances(value),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.sort),
                      onPressed: () => ShowSortOptionPopUp.show(
                        context: context,
                        todaysAttendancePresenter: _todaysAttendancePresenter,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: uiState.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : uiState.filteredAttendancesWithEmployee.isEmpty
                        ? const Center(child: Text('No attendance found'))
                        : ListView.builder(
                            itemCount:
                                uiState.filteredAttendancesWithEmployee.length,
                            itemBuilder: (context, index) {
                              final item = uiState
                                  .filteredAttendancesWithEmployee[index];
                              return TodayAttendanceItem(
                                item: item,
                                theme: theme,
                              );
                            },
                          ),
              ),
            ],
          ),
        );
      },
    );
  }
}
