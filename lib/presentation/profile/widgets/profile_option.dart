import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:flutter/material.dart';

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String text;
  final ThemeData theme;
  final VoidCallback onTap;

  const ProfileOption({
    super.key,
    required this.theme,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: fifteenPx),
        child: Container(
          padding: padding14,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: radius10,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: theme.primaryColor,
                size: twentyFivePx,
              ),
              gapW10,
              Text(
                text,
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontSize: fourteenPx,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: twentyPx,
                color: theme.textTheme.bodyMedium!.color!.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
