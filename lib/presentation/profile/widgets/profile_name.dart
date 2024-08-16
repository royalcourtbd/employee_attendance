import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:flutter/material.dart';

class ProfileName extends StatelessWidget {
  final ThemeData theme;
  final String? userName;

  const ProfileName({super.key, required this.theme, this.userName});

  @override
  Widget build(BuildContext context) {
    return Text(
      userName ?? 'null',
      style: theme.textTheme.bodyMedium!.copyWith(
        fontSize: twentyFivePx,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
