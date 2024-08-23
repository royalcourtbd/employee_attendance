import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/external_libs/flutter_animated_dialog/src/animated_dialog.dart';
import 'package:employee_attendance/core/static/svg_path.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/presentation/common/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({
    super.key,
    required this.title,
    required this.onRemove,
  });

  final String title;
  final Future<void> Function() onRemove;

  static Future<void> show({
    required BuildContext context,
    required String title,
    required Future<void> Function() onRemove,
  }) async {
    await showAnimatedDialog<void>(
      context: context,
      builder: (_) => LogOutDialog(
        onRemove: onRemove,
        title: title,
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
      shape: RoundedRectangleBorder(borderRadius: radius20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: radius10,
        ),
        height: 80.percentWidth,
        child: ClipRRect(
          borderRadius: radius12,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: EmployeeAttendanceScreen.width,
                  height: 60.percentWidth,
                  child: SvgPicture.asset(
                    SvgPath.dicBG,
                    width: EmployeeAttendanceScreen.width,
                    fit: BoxFit.fill,
                    colorFilter: buildColorFilter(theme.primaryColor),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: twentyPx),
                    child: SvgPicture.asset(
                      SvgPath.dicLogOut,
                      fit: BoxFit.cover,
                      height: 25.percentWidth,
                      colorFilter: buildColorFilter(theme.primaryColor),
                    ),
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: sixteenPx,
                      ),
                    ),
                    Padding(
                      padding: padding15,
                      child: Text(
                        'Are you sure you want to log out?',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall!.copyWith(
                          // letterSpacing: 1,
                          color: theme.textTheme.bodySmall!.color!
                              .withOpacity(0.6),
                          height: 1.8,
                          fontWeight: FontWeight.w400,
                          fontSize: thirteenPx,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ActionButton(
                          buttonText: 'Cancel',
                          width: 130.px,
                          isFocused: false,
                          onTap: () => context.navigatorPop<void>(),
                          color: theme.textTheme.bodyMedium!.color!
                              .withOpacity(0.6),
                          theme: theme,
                        ),
                        gapW15,
                        ActionButton(
                          buttonText: 'Confirm',
                          theme: theme,
                          width: 130.px,
                          color: theme.colorScheme.scrim,
                          onTap: () async {
                            await onRemove();
                            if (context.mounted) context.navigatorPop<void>();
                          },
                        ),
                      ],
                    ),
                    gapH20,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
