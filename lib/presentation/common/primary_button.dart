import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.theme,
    required this.buttonText,
    required this.onPressed,
  });

  final ThemeData theme;
  final String buttonText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding10,
        alignment: Alignment.center,
        width: EmployeeAttendanceScreen.width,
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: radius50,
        ),
        child: Text(
          buttonText,
          style: theme.textTheme.bodyMedium!.copyWith(
            color: Colors.white,
            fontSize: fourteenPx,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
