import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowDateContainer extends StatelessWidget {
  const ShowDateContainer({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isToday = _isToday(date);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: thirteenPx,
        vertical: sevenPx,
      ),
      width: 19.percentWidth,
      decoration: BoxDecoration(
        color: isToday ? theme.primaryColor : theme.colorScheme.secondary,
        borderRadius: radius10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            DateFormat('dd').format(date),
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: thirtyPx,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            DateFormat('E').format(date),
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: thirteenPx,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
