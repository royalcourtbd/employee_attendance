import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/external_libs/loading_indicator.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/domain/entities/employee_entity.dart';
import 'package:employee_attendance/presentation/profile/presenter/profile_page_presenter.dart';
import 'package:employee_attendance/presentation/profile/widgets/profile_image.dart';
import 'package:employee_attendance/presentation/profile/widgets/profile_name.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final ThemeData theme;
  final EmployeeEntity? employee;
  final VoidCallback? onEdit;
  final bool isPhotoEditable;
  final ProfilePagePresenter presenter;

  const ProfileHeader({
    super.key,
    required this.theme,
    required this.presenter,
    this.employee,
    this.onEdit,
    this.isPhotoEditable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme.primaryColor,
      width: EmployeeAttendanceScreen.width,
      height: EmployeeAttendanceScreen.height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          gapH50,
          presenter.currentUiState.isUpdatingImage
              ? LoadingIndicator(
                  theme: theme,
                  color: Colors.white,
                  ringColor: Colors.white.withValues(alpha: 0.4),
                )
              : ProfileImage(
                  profileImage: employee!.image ?? '',
                  onTap: onEdit,
                  isPhotoEditable: isPhotoEditable,
                ),
          gapH16,
          ProfileName(
            theme: theme,
            userName: employee!.name ?? 'User Name',
          ),
          gapH5,
          Text(
            employee!.employeeId ?? 'Employee ID',
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: fifteenPx,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
