import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/presentable_widget_builder.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/presentation/profile/presenter/profile_page_presenter.dart';
import 'package:employee_attendance/presentation/profile/ui/edit_profile_page.dart';
import 'package:employee_attendance/presentation/profile/widgets/copyright.dart';
import 'package:employee_attendance/presentation/profile/widgets/log_out_dialog.dart';
import 'package:employee_attendance/presentation/profile/widgets/profile_header.dart';
import 'package:employee_attendance/presentation/profile/widgets/profile_option.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final ProfilePagePresenter _profilePagePresenter =
      locate<ProfilePagePresenter>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PresentableWidgetBuilder(
        presenter: _profilePagePresenter,
        builder: () {
          return Scaffold(
            body: Column(
              children: [
                ProfileHeader(
                  theme: theme,
                  profileImage:
                      _profilePagePresenter.currentUiState.employee!.image,
                  employeeIt:
                      _profilePagePresenter.currentUiState.employee!.employeeId,
                  userName:
                      _profilePagePresenter.currentUiState.employee!.name!,
                ),
                gapH16,
                ProfileOption(
                  theme: theme,
                  onTap: () => context.navigatorPush(EditProfilePage()),
                  icon: Icons.edit,
                  text: 'Edit Profile',
                ),
                gapH16,
                ProfileOption(
                  theme: theme,
                  onTap: () => LogOutDialog.show(
                    context: context,
                    title: 'Sign Out',
                    onRemove: () => _profilePagePresenter.logout(),
                  ),
                  icon: Icons.logout,
                  text: 'Log Out',
                ),
                const Spacer(),
                Copyright(theme: theme),
                gapH30,
              ],
            ),
          );
        });
  }
}
