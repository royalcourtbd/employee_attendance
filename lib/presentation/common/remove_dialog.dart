import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/external_libs/flutter_animated_dialog/src/animated_dialog.dart';
import 'package:employee_attendance/core/static/svg_path.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RemoveDialog extends StatelessWidget {
  const RemoveDialog({
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
      builder: (_) => RemoveDialog(
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
      elevation: 0,
      backgroundColor: Colors.white,
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
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: twentyPx),
                  child: SvgPicture.asset(
                    SvgPath.icDelete,
                    fit: BoxFit.cover,
                    height: 25.percentWidth,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Delete $title".tr,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: sixteenPx,
                      ),
                    ),
                    Padding(
                      padding: padding15,
                      child: Text(
                        'You will not be able to recover this \n$title file!'
                            .tr,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall!.copyWith(
                          // letterSpacing: 1,
                          color: theme.textTheme.bodySmall!.color!
                              .withValues(alpha: .6),
                          height: 1.8,
                          fontWeight: FontWeight.w400,
                          fontSize: thirteenPx,
                        ),
                      ),
                    ),
                    gapH15,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     ActionButton(
                    //       buttonText: 'Cancel',
                    //       width: 130,
                    //       isFocused: false,
                    //       theme: theme,
                    //       color: theme.textTheme.bodyMedium!.color!
                    //           .withValues(0.6),
                    //       onTap: () => context.navigatorPop<void>(),
                    //     ),
                    //     gapW15,
                    //     ActionButton(
                    //       buttonText: 'Delete',
                    //       isError: true,
                    //       color: theme.colorScheme.scrim,
                    //       width: 130,
                    //       theme: theme,
                    //       onTap: () async {
                    //         await onRemove();
                    //         if (context.mounted) context.navigatorPop<void>();
                    //       },
                    //     ),
                    //   ],
                    // ),
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
