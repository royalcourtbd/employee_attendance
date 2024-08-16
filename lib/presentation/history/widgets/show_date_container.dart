import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:flutter/material.dart';

class ShowDateContainer extends StatelessWidget {
  const ShowDateContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: fifteenPx,
        vertical: sevenPx,
      ),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: radius10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '26',
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: thirtyPx,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'Thu',
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: thirteenPx,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
