// lib/presentation/profile/widgets/profile_designation.dart

import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:flutter/material.dart';

class ProfileDesignation extends StatelessWidget {
  final ThemeData theme;
  final String designation;

  const ProfileDesignation({
    super.key,
    required this.theme,
    required this.designation,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      designation,
      style: theme.textTheme.bodyMedium!.copyWith(
        fontSize: fourteenPx,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    );
  }
}
