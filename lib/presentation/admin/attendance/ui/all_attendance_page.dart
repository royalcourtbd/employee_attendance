import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/loading_indicator.dart';
import 'package:employee_attendance/core/external_libs/presentable_widget_builder.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/presentation/admin/attendance/presenter/all_attendance_presenter.dart';
import 'package:employee_attendance/presentation/admin/attendance/widgets/attendance_list_item.dart';
import 'package:employee_attendance/presentation/common/date_picker_widget.dart';
import 'package:employee_attendance/presentation/login/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class AllAttendancePage extends StatelessWidget {
  AllAttendancePage({super.key});

  final AllAttendancePresenter _allAttendancePresenter =
      locate<AllAttendancePresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: _allAttendancePresenter,
      onInit: () => _allAttendancePresenter.initPage(),
      builder: () {
        final uiState = _allAttendancePresenter.currentUiState;
        return PopScope(
          canPop: true,
          onPopInvokedWithResult: (isInvoked, result) {
            _allAttendancePresenter.resetFilters();
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('All Attendances'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  _allAttendancePresenter.resetFilters();
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: padding10,
                  child: CustomTextField(
                    theme: theme,
                    textEditingController:
                        _allAttendancePresenter.searchController,
                    hintText: 'Search by name or employee ID',
                    onChanged: (value) => _allAttendancePresenter
                        .filterAttendances(searchQuery: value),
                  ),
                ),
                Padding(
                  padding: padding10,
                  child: Row(
                    children: [
                      Expanded(
                        child: DatePickerWidget(
                          selectedDate: uiState.startDate ?? DateTime.now(),
                          onDateSelected: (date) => _allAttendancePresenter
                              .filterAttendances(startDate: date),
                          labelText: 'Start Date',
                        ),
                      ),
                      gapW10,
                      Expanded(
                        child: DatePickerWidget(
                          selectedDate: uiState.endDate ?? DateTime.now(),
                          onDateSelected: (date) => _allAttendancePresenter
                              .filterAttendances(endDate: date),
                          labelText: 'End Date',
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: uiState.isLoading
                      ? LoadingIndicator(
                          theme: theme,
                          color: theme.primaryColor,
                          ringColor: theme.primaryColor.withOpacity(0.5),
                        )
                      : NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            if (scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                              _allAttendancePresenter.loadMoreItems();
                            }
                            return true;
                          },
                          child: ListView.builder(
                            itemCount: uiState.filteredAttendances.length + 1,
                            itemBuilder: (context, index) {
                              if (index == uiState.filteredAttendances.length) {
                                return uiState.filteredAttendances.length <
                                        uiState.totalItems
                                    ? LoadingIndicator(
                                        theme: theme,
                                        color: theme.primaryColor,
                                        ringColor:
                                            theme.primaryColor.withOpacity(0.5),
                                      )
                                    : const SizedBox.shrink();
                              }
                              final attendance =
                                  uiState.filteredAttendances[index];
                              return AttendanceListItem(
                                theme: theme,
                                name: attendance.employee.name,
                                employeeNetworkImageURL:
                                    attendance.employee.image,
                                checkInTime: attendance.attendance.checkInTime,
                                checkOutTime:
                                    attendance.attendance.checkOutTime,
                                workDuration:
                                    attendance.attendance.workDuration,
                                date: attendance.attendance.checkInTime,
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
