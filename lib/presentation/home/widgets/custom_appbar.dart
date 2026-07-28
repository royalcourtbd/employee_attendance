import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/presentation/common/profile_pic_widget.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String greetingMessage;
  final String profileImageUrl;
  final ThemeData theme;
  final VoidCallback onProfileTap;

  const CustomAppBar({
    super.key,
    required this.theme,
    required this.userName,
    required this.greetingMessage,
    required this.profileImageUrl,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      toolbarHeight: EmployeeAttendanceScreen.height * 0.12,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hey $userName!',
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: twentyFivePx, // or any size you prefer
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            greetingMessage,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: thirteenPx, // or any size you prefer
              color: theme.textTheme.bodyMedium!.color!.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
      actions: [
        InkWell(
          onTap: onProfileTap,
          child: ProfilePicWidget(
            theme: theme,
            networkImageURL: profileImageUrl,
          ),
        ),
        gapW15
      ],
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(EmployeeAttendanceScreen.height * 0.12);
}
