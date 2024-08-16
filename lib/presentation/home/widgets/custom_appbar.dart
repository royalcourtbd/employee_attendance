import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String greetingMessage;
  final String profileImageUrl;
  final ThemeData theme;

  const CustomAppBar({
    super.key,
    required this.theme,
    required this.userName,
    required this.greetingMessage,
    required this.profileImageUrl,
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
              color: theme.textTheme.bodyMedium!.color!.withOpacity(0.8),
            ),
          ),
        ],
      ),
      actions: [
        ClipRRect(
          borderRadius: radius50,
          child: CachedNetworkImage(
            imageUrl: profileImageUrl,
            placeholder: (context, url) =>
                const Icon(Icons.image, color: Colors.grey),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            width: EmployeeAttendanceScreen.width * 0.13,
            height: EmployeeAttendanceScreen.width * 0.13,
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
