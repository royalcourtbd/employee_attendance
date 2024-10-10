import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/presentable_widget_builder.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/presentation/common/log_out_dialog.dart';
import 'package:employee_attendance/presentation/profile/presenter/profile_page_presenter.dart';
import 'package:employee_attendance/presentation/profile/ui/view_profile_page.dart';
import 'package:employee_attendance/presentation/profile/widgets/copyright.dart';
import 'package:employee_attendance/presentation/profile/widgets/password_change_popup.dart';
import 'package:employee_attendance/presentation/profile/widgets/profile_header.dart';
import 'package:employee_attendance/presentation/profile/widgets/profile_option_tile.dart';
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileHeader(
                        theme: theme,
                        employee: _profilePagePresenter.currentUiState.employee,
                        presenter: _profilePagePresenter,
                      ),
                      gapH16,
                      ProfileOptionTile(
                        theme: theme,
                        onTap: () => context.navigatorPush(ViewProfilePage()),
                        icon: Icons.account_circle,
                        text: 'View Profile',
                      ),
                      gapH16,
                      ProfileOptionTile(
                        theme: theme,
                        onTap: () => PasswordChangePopup.show(
                          context: context,
                          onPasswordChange: () =>
                              _profilePagePresenter.changePassword(context),
                        ),
                        icon: Icons.edit,
                        text: 'Edit Password',
                      ),
                      gapH16,
                      ProfileOptionTile(
                        theme: theme,
                        onTap: () => LogOutDialog.show(
                          context: context,
                          title: 'Sign Out',
                          onRemove: () => _profilePagePresenter.logout(),
                        ),
                        icon: Icons.logout,
                        text: 'Log Out',
                      ),
                    ],
                  ),
                ),
              ),
              Copyright(theme: theme),
              gapH30,
            ],
          ),
        );
      },
    );
  }
}
