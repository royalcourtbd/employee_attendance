import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/external_libs/flutter_animated_dialog/src/animated_dialog.dart';
import 'package:employee_attendance/core/static/svg_path.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/presentation/common/primary_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class NewAppUpdateDialog extends StatelessWidget {
  const NewAppUpdateDialog({
    super.key,
  });

  static Future<void> show(
    BuildContext context,
  ) async {
    await showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const NewAppUpdateDialog(),
      barrierColor: Colors.black.withOpacity(0.5),
      animationType: DialogTransitionType.slideFromBottom,
      curve: Curves.bounceIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AlertDialog(
      insetPadding:
          EdgeInsets.symmetric(horizontal: fourteenPx, vertical: twentyPx),
      actionsPadding: EdgeInsets.symmetric(vertical: fivePx),
      contentPadding: EdgeInsets.zero,
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: theme.scaffoldBackgroundColor,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(tenPx),
        ),
        width: EmployeeAttendanceScreen.width,
        height: 85.percentWidth,
        child: ClipRRect(
          borderRadius: radius12,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: EmployeeAttendanceScreen.width,
                  height: 65.percentWidth,
                  child: SvgPicture.asset(
                    SvgPath.dicBG,
                    fit: BoxFit.fill,
                    width: EmployeeAttendanceScreen.width,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: fifteenPx),
                  child: SvgPicture.asset(
                    SvgPath.icDataNotFound,
                    fit: BoxFit.cover,
                    height: 25.percentWidth,
                    colorFilter:
                        buildColorFilterToChangeColor(theme.primaryColor),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: padding20,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Update Your App',
                        style: theme.textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      gapH15,
                      SizedBox(
                        width: EmployeeAttendanceScreen.width,
                        height: 20.percentWidth,
                        child: Text(
                          'A new version of the app is available. Please update to continue using the app.',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      gapH15,
                      PrimaryButton(
                        theme: theme,
                        buttonText: 'Update',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
