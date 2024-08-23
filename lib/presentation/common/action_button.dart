import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.buttonText,
    this.isFocused = true,
    this.height,
    required this.width,
    this.padding = const EdgeInsets.symmetric(horizontal: 34, vertical: 12),
    required this.onTap,
    this.color,
    this.isError = false,
    required this.theme,
  });

  final String buttonText;
  final Color? color;
  final bool isFocused;
  final void Function() onTap;
  final double? height;
  final double width;
  final EdgeInsets padding;
  final bool isError;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 40,
        decoration: BoxDecoration(
          borderRadius: radius10,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: thirteenPx,
              color: color ??
                  (isError
                      ? theme.colorScheme.error
                      : isFocused
                          ? theme.primaryColor
                          : theme.textTheme.bodyMedium!.color),
            ),
          ),
        ),
      ),
    );
  }
}
