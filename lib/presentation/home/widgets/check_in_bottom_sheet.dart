// ignore_for_file: use_build_context_synchronously

import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/presentation/common/custom_botom_sheet_container.dart';
import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';

class CheckInBottomSheet extends StatelessWidget {
  final VoidCallback onCheckIn;
  final String title;

  const CheckInBottomSheet({
    super.key,
    required this.onCheckIn,
    required this.title,
  });

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onCheckIn,
    required String title,
  }) async {
    final CheckInBottomSheet checkInBottomSheet = await Future.microtask(
      () => CheckInBottomSheet(
        onCheckIn: onCheckIn,
        title: title,
        key: const Key("CheckInBottomSheet"),
      ),
    );

    if (context.mounted) {
      await context.showBottomSheet<void>(checkInBottomSheet, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return CustomBottomSheetContainer(
      key: const Key('CheckInBottomSheet'),
      theme: theme,
      children: [
        Center(
          child: SliderButton(
            width: 90.percentWidth,
            alignLabel: const Alignment(0.2, 0.0),
            action: () async {
              onCheckIn.call();
              await Future.delayed(const Duration(seconds: 1));
              context.navigatorPop();
              return Future.value(true);
            },
            label: Text(
              "Slide to $title",
              style: theme.textTheme.bodyMedium!.copyWith(),
            ),
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            buttonColor: theme.primaryColor,
            buttonSize: 50,
          ),
        )
      ],
    );
  }
}
