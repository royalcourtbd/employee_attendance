import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/svg_path.dart';
import 'package:flutter/material.dart';

class ProfilePicWidget extends StatelessWidget {
  const ProfilePicWidget({
    super.key,
    required this.theme,
    required this.networkImageURL,
  });

  final ThemeData theme;
  final String networkImageURL;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: theme.primaryColor,
          width: 2,
        ),
      ),
      child: ClipOval(
        child: networkImageURL.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: networkImageURL,
                placeholder: (context, url) =>
                    const Icon(Icons.image, color: Colors.grey),
                errorWidget: (context, url, error) =>
                    Image.asset(SvgPath.icDemoUser),
                width: EmployeeAttendanceScreen.width * 0.13,
                height: EmployeeAttendanceScreen.width * 0.13,
                fit: BoxFit.cover,
              )
            : Image.asset(
                SvgPath.icDemoUser,
                width: EmployeeAttendanceScreen.width * 0.13,
                height: EmployeeAttendanceScreen.width * 0.13,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
