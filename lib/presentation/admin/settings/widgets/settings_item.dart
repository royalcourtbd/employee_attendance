import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const SettingsItem({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: tenPx, vertical: fivePx),
      child: Container(
        padding: padding10,
        decoration: BoxDecoration(
          color: theme.cardColor.withValues(alpha: .5),
          borderRadius: radius10,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          minVerticalPadding: 0,
          title: Text(
            title,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: sixteenPx,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(value, style: GoogleFonts.koHo(fontSize: thirteenPx)),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
      ),
    );
  }
}
