import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:flutter/material.dart';

class AdminDashboardGridItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final ThemeData theme;

  const AdminDashboardGridItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding10,
        decoration: BoxDecoration(
          color: theme.cardColor.withOpacity(0.5),
          borderRadius: radius10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48),
            const SizedBox(height: 8),
            Text(title),
          ],
        ),
      ),
    );
  }
}
