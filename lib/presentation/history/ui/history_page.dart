import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/presentation/history/widgets/attendance_item.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance History'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: padding15,
        itemCount: 10,
        itemBuilder: (_, index) => AttendanceItem(theme: theme),
      ),
    );
  }
}
