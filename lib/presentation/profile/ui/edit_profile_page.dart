import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/presentation/profile/presenter/edit_profile_presenter.dart';
import 'package:employee_attendance/presentation/profile/widgets/edit_profile_form.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});

  final EditProfilePresenter _presenter = locate<EditProfilePresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingH16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapH30,
              Text(
                'Update Your Profile',
                style: theme.textTheme.headlineSmall,
              ),
              gapH20,
              EditProfileForm(
                presenter: _presenter,
                theme: theme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
