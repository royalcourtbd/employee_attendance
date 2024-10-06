import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/flutter_animated_dialog/src/animated_dialog.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/presentation/admin/settings/presenter/settings_presenter.dart';
import 'package:employee_attendance/presentation/login/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class UpdateLatitudeLongitudePopup extends StatelessWidget {
  UpdateLatitudeLongitudePopup(
      {super.key, required this.updateLatitudeLongitude});
  final VoidCallback updateLatitudeLongitude;

  static Future<void> show({
    required BuildContext context,
    required VoidCallback updateLatitudeLongitude,
  }) async {
    await showAnimatedDialog(
      context: context,
      builder: (context) => UpdateLatitudeLongitudePopup(
        updateLatitudeLongitude: updateLatitudeLongitude,
      ),
      animationType: DialogTransitionType.scale,
      curve: Curves.fastOutSlowIn,
      barrierDismissible: true,
    );
  }

  final SettingsPresenter _settingsPresenter = locate<SettingsPresenter>();

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
              'Update Location',
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: twentyPx,
                fontWeight: FontWeight.bold,
              ),
            ),
            gapH20,
            CustomTextField(
              textEditingController: _settingsPresenter.latitudeTextController,
              theme: theme,
              hintText: 'Enter latitude',
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            gapH20,
            CustomTextField(
              textEditingController: _settingsPresenter.longitudeTextController,
              theme: theme,
              hintText: 'Enter longitude',
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            gapH20,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    _settingsPresenter.latitudeTextController.clear();
                    _settingsPresenter.longitudeTextController.clear();
                    context.navigatorPop();
                  },
                  child: Text(
                    'Cancel',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => updateLatitudeLongitude(),
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
