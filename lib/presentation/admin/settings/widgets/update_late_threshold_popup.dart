import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/presentation/admin/settings/presenter/settings_presenter.dart';
import 'package:employee_attendance/presentation/login/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class UpdateLateThresholdPopup extends StatelessWidget {
  UpdateLateThresholdPopup({super.key, required this.updateThreshold});
  final VoidCallback updateThreshold;
  final SettingsPresenter _settingsPresenter = locate<SettingsPresenter>();

  static Future<void> show(
      {required BuildContext context,
      required VoidCallback updateThreshold}) async {
    await showAnimatedDialog(
      context: context,
      builder: (context) => UpdateLateThresholdPopup(
        updateThreshold: updateThreshold,
      ),
      animationType: DialogTransitionType.scale,
      curve: Curves.fastOutSlowIn,
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Update Late Threshold',
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: twentyPx,
                fontWeight: FontWeight.bold,
              ),
            ),
            gapH20,
            CustomTextField(
              emailController: _settingsPresenter.thresholdController,
              theme: theme,
              hintText: 'Write new late threshold here',
              keyboardType: TextInputType.number,
            ),
            gapH20,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => context.navigatorPop(),
                  child: Text(
                    'Cancel',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (_settingsPresenter
                            .thresholdController.text.isNotEmpty &&
                        int.tryParse(
                                _settingsPresenter.thresholdController.text) !=
                            null &&
                        int.parse(_settingsPresenter.thresholdController.text) >
                            0) {
                      updateThreshold();
                      context.navigatorPop();
                    }
                  },
                  child: Text(
                    'Update',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}