import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/loading_indicator.dart';
import 'package:employee_attendance/core/external_libs/presentable_widget_builder.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/presentation/history/presenter/history_page_presenter.dart';
import 'package:employee_attendance/presentation/history/widgets/attendance_calendar.dart';
import 'package:employee_attendance/presentation/history/widgets/attendance_history_item.dart';
import 'package:employee_attendance/presentation/history/widgets/empty_attendance_view.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});
  final HistoryPagePresenter _historyPagePresenter =
      locate<HistoryPagePresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: _historyPagePresenter,
      builder: () {
        final uiState = _historyPagePresenter.currentUiState;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Attendance History'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              AttendanceCalendar(
                theme: theme,
                presenter: _historyPagePresenter,
              ),
              Expanded(
                child: uiState.isLoading
                    ? LoadingIndicator(
                        theme: theme,
                        color: theme.primaryColor,
                        ringColor: theme.primaryColor.withOpacity(0.5),
                      )
                    : uiState.filteredAttendances.isEmpty
                        ? const EmptyAttendanceView()
                        : ListView.builder(
                            padding: padding15,
                            itemCount: uiState.filteredAttendances.length,
                            itemBuilder: (_, index) => AttendanceHistoryItem(
                              theme: theme,
                              attendance: uiState.filteredAttendances[index],
                            ),
                          ),
              )
            ],
          ),
        );
      },
    );
  }
}
