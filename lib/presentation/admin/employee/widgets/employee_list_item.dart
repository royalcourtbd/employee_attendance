import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:employee_attendance/presentation/common/profile_pic_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmployeeListItem extends StatelessWidget {
  final Employee employee;
  final VoidCallback onEdit;
  final ThemeData theme;

  const EmployeeListItem({
    super.key,
    required this.employee,
    required this.onEdit,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: tenPx, vertical: fivePx),
          child: Container(
            padding: padding10,
            decoration: BoxDecoration(
              color: theme.cardColor.withOpacity(0.5),
              borderRadius: radius10,
            ),
            child: Row(
              children: [
                ProfilePicWidget(
                    theme: theme, networkImageURL: employee.image ?? ''),
                gapW10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(employee.name ?? '',
                        style: GoogleFonts.koHo(
                          fontWeight: FontWeight.w600,
                          fontSize: sixteenPx,
                        )),
                    Text(
                      'as a ${employee.designation}',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontSize: thirteenPx,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                CircleAvatar(
                  backgroundColor: employee.employeeStatus
                      ? theme.colorScheme.primary
                      : theme.colorScheme.error,
                  radius: sevenPx,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
