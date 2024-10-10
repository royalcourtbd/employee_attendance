import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/flutter_animated_dialog/src/animated_dialog.dart';
import 'package:employee_attendance/core/external_libs/presentable_widget_builder.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/presentation/common/loading_button_widget.dart';
import 'package:employee_attendance/presentation/login/widgets/custom_text_field.dart';
import 'package:employee_attendance/presentation/profile/presenter/profile_page_presenter.dart';
import 'package:flutter/material.dart';

class PasswordChangePopup extends StatelessWidget {
  PasswordChangePopup({super.key, this.onPasswordChange});
  final VoidCallback? onPasswordChange;

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onPasswordChange,
  }) async {
    await showAnimatedDialog(
      context: context,
      builder: (context) =>
          PasswordChangePopup(onPasswordChange: onPasswordChange),
      animationType: DialogTransitionType.scale,
      curve: Curves.fastOutSlowIn,
      barrierDismissible: true,
    );
  }

  final ProfilePagePresenter _profilePagePresenter =
      locate<ProfilePagePresenter>();
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
        presenter: _profilePagePresenter,
        builder: () {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: twentyPx),
            backgroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: radius10,
            ),
            child: Container(
              padding: padding20,
              decoration: BoxDecoration(
                borderRadius: radius10,
              ),
              child: Form(
                key: _profilePagePresenter.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Update Password',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontSize: twentyPx,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    gapH20,
                    CustomTextField(
                      textEditingController:
                          _profilePagePresenter.currentPasswordController,
                      theme: theme,
                      hintText: 'Write your current password',
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        _profilePagePresenter.formKey.currentState!.validate();
                      },
                      icon: Icons.lock,
                      isPassword: true,
                      validator: validatePassword,
                    ),
                    gapH10,
                    CustomTextField(
                      textEditingController:
                          _profilePagePresenter.newPasswordController,
                      theme: theme,
                      hintText: 'Write your new password',
                      keyboardType: TextInputType.text,
                      icon: Icons.lock,
                      isPassword: true,
                      validator: validatePassword,
                      onChanged: (value) {
                        _profilePagePresenter.formKey.currentState!.validate();
                      },
                    ),
                    gapH10,
                    CustomTextField(
                      textEditingController:
                          _profilePagePresenter.confirmPasswordController,
                      theme: theme,
                      hintText: 'Confirm your new password',
                      keyboardType: TextInputType.text,
                      icon: Icons.lock,
                      isPassword: true,
                      validator: validatePassword,
                      onChanged: (value) {
                        _profilePagePresenter.formKey.currentState!.validate();
                      },
                    ),
                    gapH20,
                    LoadingButtonWidget(
                        isLoading:
                            _profilePagePresenter.currentUiState.isLoading,
                        theme: theme,
                        buttonText: 'Change Password',
                        onPressed: () {
                          onPasswordChange!.call();
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
