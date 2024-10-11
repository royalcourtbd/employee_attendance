import 'package:employee_attendance/core/external_libs/animate_do/fades.dart';

import 'package:employee_attendance/core/external_libs/animate_do/slides.dart';
import 'package:employee_attendance/core/external_libs/loading_indicator.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/presentation/history/presenter/history_page_presenter.dart';
import 'package:employee_attendance/presentation/history/widgets/attendance_history_item.dart';
import 'package:employee_attendance/presentation/history/widgets/empty_attendance_view.dart';
import 'package:flutter/material.dart';

class BuildHistoryPageBodySection extends StatelessWidget {
  const BuildHistoryPageBodySection({
    super.key,
    required this.historyPagePresenter,
    required this.theme,
  });

  final HistoryPagePresenter historyPagePresenter;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final uiState = historyPagePresenter.currentUiState;

    if (uiState.isLoading) {
      return LoadingIndicator(
        theme: theme,
        color: theme.primaryColor,
        ringColor: theme.primaryColor.withOpacity(0.5),
      );
    } else if (uiState.filteredAttendances.isEmpty) {
      return const EmptyAttendanceView();
    } else {
      final listKey = ValueKey(
          '${uiState.selectedMonth.year}-${uiState.selectedMonth.month}');

      return ListView.builder(
        key: listKey,
        padding: padding15,
        itemCount: uiState.filteredAttendances.length,
        itemBuilder: (_, index) => FadeIn(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 50 * index),
          child: SlideInUp(
            from: 50,
            duration: const Duration(milliseconds: 500),
            delay: Duration(milliseconds: 50 * index),
            child: AttendanceHistoryItem(
              theme: theme,
              attendance: uiState.filteredAttendances[index],
            ),
          ),
        ),
      );
    }
  }
}
