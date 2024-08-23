import 'package:employee_attendance/core/external_libs/loading_indicator.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/presentation/history/presenter/history_page_presenter.dart';
import 'package:employee_attendance/presentation/history/widgets/attendance_item.dart';
import 'package:employee_attendance/presentation/history/widgets/empty_attendance_view.dart';
import 'package:flutter/material.dart';

class BuildHistoryPageBodySection extends StatelessWidget {
  const BuildHistoryPageBodySection(
      {super.key, required this.historyPagePresenter, required this.theme});

  final HistoryPagePresenter historyPagePresenter;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    if (historyPagePresenter.currentUiState.isLoading) {
      return LoadingIndicator(
        theme: theme,
        color: theme.primaryColor,
        ringColor: theme.primaryColor.withOpacity(0.5),
      );
    } else if (historyPagePresenter.currentUiState.attendances.isEmpty) {
      return const EmptyAttendanceView();
    } else {
      return ListView.builder(
        padding: padding15,
        itemCount: historyPagePresenter.currentUiState.attendances.length,
        itemBuilder: (_, index) => AttendanceItem(
          theme: theme,
          attendance: historyPagePresenter.currentUiState.attendances[index],
        ),
      );
    }
  }
}
