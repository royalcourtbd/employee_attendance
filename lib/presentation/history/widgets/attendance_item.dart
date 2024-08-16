import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/presentation/history/widgets/show_date_container.dart';
import 'package:flutter/material.dart';

class AttendanceItem extends StatelessWidget {
  const AttendanceItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: tenPx),
      child: Container(
        padding: padding15,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: radius10,
        ),
        child: Row(
          children: [
            const ShowDateContainer(),
            // Add more widgets here for additional attendance information
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '09:00 AM',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: sixteenPx,
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .color!
                            .withOpacity(0.6),
                      ),
                ),
                Text(
                  'Check In',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: sixteenPx,
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .color!
                            .withOpacity(0.6),
                      ),
                ),
                const Divider()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
