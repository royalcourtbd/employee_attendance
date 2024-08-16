import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:flutter/material.dart';

class ProfilePhone extends StatelessWidget {
  final ThemeData theme;
  final String? phone;

  const ProfilePhone({super.key, required this.theme, this.phone});

  @override
  Widget build(BuildContext context) {
    return Text(
      phone ?? '+88017',
      style: theme.textTheme.bodyMedium!.copyWith(
        fontSize: fifteenPx,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }
}
