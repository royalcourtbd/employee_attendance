import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/constants.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/presentation/profile/widgets/profile_image.dart';
import 'package:employee_attendance/presentation/profile/widgets/profile_name.dart';
import 'package:employee_attendance/presentation/profile/widgets/profile_phone.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final ThemeData theme;

  const ProfileHeader({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme.primaryColor,
      width: EmployeeAttendanceScreen.width,
      height: EmployeeAttendanceScreen.height * 0.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          gapH50,
          const ProfileImage(userImage: image),
          gapH16,
          ProfileName(theme: theme, userName: 'Shaikh Ahmadullah'),
          gapH10,
          ProfilePhone(theme: theme, phone: '+880 1234567890'),
        ],
      ),
    );
  }
}
