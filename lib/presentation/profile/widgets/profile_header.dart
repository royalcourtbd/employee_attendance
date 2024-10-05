import 'package:employee_attendance/core/config/employee_attendance_screen.dart';

import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:employee_attendance/presentation/profile/widgets/profile_image.dart';
import 'package:employee_attendance/presentation/profile/widgets/profile_name.dart';
import 'package:employee_attendance/presentation/profile/widgets/profile_phone.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final ThemeData theme;
  final Employee? employee;

  const ProfileHeader({
    super.key,
    required this.theme,
    this.employee,
  });

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
          ProfileImage(profileImage: employee!.image ?? ''),
          gapH16,
          ProfileName(
            theme: theme,
            userName: employee!.name ?? 'User Name',
          ),
          gapH10,
          ProfileId(theme: theme, employeeId: employee!.employeeId ?? ''),
        ],
      ),
    );
  }
}
