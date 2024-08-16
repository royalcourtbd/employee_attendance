import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/presentation/profile/widgets/copyright.dart';
import 'package:employee_attendance/presentation/profile/widgets/profile_header.dart';
import 'package:employee_attendance/presentation/profile/widgets/profile_option.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          ProfileHeader(theme: theme),
          gapH16,
          ProfileOption(
            theme: theme,
            onTap: () {},
            icon: Icons.edit,
            text: 'Edit Profile',
          ),
          gapH16,
          ProfileOption(
            theme: theme,
            onTap: () {},
            icon: Icons.logout,
            text: 'Log Out',
          ),
          const Spacer(),
          Copyright(theme: theme),
          gapH30,
        ],
      ),
    );
  }
}
