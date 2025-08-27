import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key, required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome',
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: thirtyPx,
              fontWeight: FontWeight.bold,
            ),
          ),
          gapH5,
          Text(
            'Login to your account',
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: fourteenPx,
              color: theme.textTheme.bodyMedium!.color!.withValues(alpha: .6),
            ),
          ),
        ],
      ),
    );
  }
}
