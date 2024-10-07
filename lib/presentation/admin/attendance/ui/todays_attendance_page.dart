// lib/presentation/admin/attendance/ui/todays_attendance_page.dart

import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/presentable_widget_builder.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/presentation/admin/attendance/presenter/todays_attendance_presenter.dart';
import 'package:employee_attendance/presentation/admin/attendance/presenter/todays_attendance_ui_state.dart';
import 'package:employee_attendance/presentation/common/profile_pic_widget.dart';
import 'package:employee_attendance/presentation/employee_attendance.dart';
import 'package:employee_attendance/presentation/home/presenter/home_presenter.dart';
import 'package:employee_attendance/presentation/login/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TodaysAttendancePage extends StatelessWidget {
  TodaysAttendancePage({super.key});

  final TodaysAttendancePresenter _todaysAttendancePresenter =
      locate<TodaysAttendancePresenter>();

  final HomePresenter homePresenter = locate<HomePresenter>();

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
              _buildSummary(uiState, theme),
              _buildSearchAndSort(uiState, theme),
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
                              return _buildAttendanceItem(item, theme);
                            },
                          ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummary(TodaysAttendanceUiState uiState, ThemeData theme) {
    return Container(
      padding: padding15,
      color: theme.primaryColor.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem(
              'Total Present', uiState.summary.totalPresent.toString(), theme),
          _buildSummaryItem(
              'Total Late', uiState.summary.totalLate.toString(), theme),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, ThemeData theme) {
    return Column(
      children: [
        Text(label, style: theme.textTheme.bodySmall),
        Text(value,
            style: theme.textTheme.titleLarge
                ?.copyWith(color: theme.primaryColor)),
      ],
    );
  }

  Widget _buildSearchAndSort(TodaysAttendanceUiState uiState, ThemeData theme) {
    return Padding(
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
            onPressed: () => _showSortOptions(uiState),
          ),
        ],
      ),
    );
  }

  void _showSortOptions(TodaysAttendanceUiState uiState) {
    showDialog(
      context: EmployeeAttendance.globalContext,
      builder: (context) => SimpleDialog(
        title: const Text('Sort by'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              _todaysAttendancePresenter
                  .sortAttendances(SortCriteria.checkInTime);
              Navigator.pop(context);
            },
            child: const Text('Check-in Time'),
          ),
          SimpleDialogOption(
            onPressed: () {
              _todaysAttendancePresenter.sortAttendances(SortCriteria.name);
              Navigator.pop(context);
            },
            child: const Text('Name'),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceItem(AttendanceWithEmployee item, ThemeData theme) {
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
                  '${DateFormat('hh:mm a').format(item.attendance.checkInTime)} - ${item.attendance.checkOutTime != null ? DateFormat('hh:mm a').format(item.attendance.checkOutTime!) : '--:--'}',
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
                  'Hours:',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: thirteenPx,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  homePresenter
                      .getFormattedDuration(item.attendance.workDuration),
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
