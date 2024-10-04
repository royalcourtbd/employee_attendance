import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/presentation/common/primary_button.dart';

import 'package:employee_attendance/presentation/login/widgets/custom_text_field.dart';
import 'package:employee_attendance/presentation/profile/presenter/edit_profile_presenter.dart';
import 'package:flutter/material.dart';

class EditProfileForm extends StatelessWidget {
  final EditProfilePresenter presenter;
  final ThemeData theme;

  const EditProfileForm({
    super.key,
    required this.presenter,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: presenter.formKey,
      child: Column(
        children: [
          CustomTextField(
            textEditingController: presenter.nameController,
            theme: theme,
            hintText: 'Enter your name',
            onChanged: (value) {},
            icon: Icons.person,
          ),
          gapH25,
          CustomTextField(
            textEditingController: presenter.emailController,
            theme: theme,
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {},
            icon: Icons.email,
          ),
          gapH25,
          CustomTextField(
            textEditingController: presenter.phoneController,
            theme: theme,
            hintText: 'Enter your phone number',
            keyboardType: TextInputType.phone,
            onChanged: (value) {},
            icon: Icons.phone,
          ),
          gapH40,
          PrimaryButton(
            theme: theme,
            onPressed: () {},
            buttonText: 'Save Profile',
          ),
        ],
      ),
    );
  }
}
