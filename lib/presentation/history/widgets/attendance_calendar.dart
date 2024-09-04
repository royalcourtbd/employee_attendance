import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:employee_attendance/presentation/history/presenter/history_page_presenter.dart';

class AttendanceCalendar extends StatelessWidget {
  const AttendanceCalendar({
    required this.theme,
    required this.presenter,
    super.key,
  });

  final ThemeData theme;
  final HistoryPagePresenter presenter;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2024, 1, 1),
      lastDay: DateTime.utc(2050, 12, 31),
      focusedDay: presenter.currentUiState.selectedMonth,
      currentDay: DateTime.now(),
      calendarFormat: CalendarFormat.twoWeeks,
      onPageChanged: presenter.updateSelectedMonth,
      onDaySelected: presenter.onDaySelected,
      selectedDayPredicate: (day) {
        return isSameDay(presenter.currentUiState.selectedMonth, day);
      },
      holidayPredicate: presenter.isHoliday,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: theme.primaryColor,
          shape: BoxShape.circle,
        ),
        todayTextStyle: const TextStyle(color: Colors.white),
        selectedDecoration: BoxDecoration(
          color: theme.primaryColor,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: const TextStyle(color: Colors.white),
        holidayDecoration: BoxDecoration(
          border: Border.all(color: Colors.red),
          shape: BoxShape.circle,
        ),
        holidayTextStyle: const TextStyle(color: Colors.red),
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
    );
  }
}
