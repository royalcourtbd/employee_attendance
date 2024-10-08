import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/external_libs/flutter_animated_dialog/src/animated_dialog.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/presentation/admin/attendance/presenter/todays_attendance_presenter.dart';
import 'package:employee_attendance/presentation/admin/attendance/presenter/todays_attendance_ui_state.dart';
import 'package:flutter/material.dart';

class ShowSortOptionPopUp extends StatelessWidget {
  const ShowSortOptionPopUp({
    super.key,
    required this.todaysAttendancePresenter,
  });
  final TodaysAttendancePresenter todaysAttendancePresenter;

  static Future<void> show({
    required BuildContext context,
    required TodaysAttendancePresenter todaysAttendancePresenter,
  }) async {
    await showAnimatedDialog(
      context: context,
      builder: (context) => ShowSortOptionPopUp(
        todaysAttendancePresenter: todaysAttendancePresenter,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sort by',
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: twentyPx,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
                onPressed: () {
                  todaysAttendancePresenter
                      .sortAttendances(SortCriteria.checkInTime);
                  context.navigatorPop();
                },
                child: const Text('Check-in Time')),
            TextButton(
                onPressed: () {
                  todaysAttendancePresenter.sortAttendances(SortCriteria.name);
                  context.navigatorPop();
                },
                child: const Text('Name')),
          ],
        ),
      ),
    );
  }
}
