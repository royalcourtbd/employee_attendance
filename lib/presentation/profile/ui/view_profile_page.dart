import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/presentable_widget_builder.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:employee_attendance/presentation/profile/presenter/profile_page_presenter.dart';
import 'package:employee_attendance/presentation/profile/widgets/profile_header.dart';
import 'package:employee_attendance/presentation/profile/widgets/profile_info_item.dart.dart';
import 'package:flutter/material.dart';

class ViewProfilePage extends StatelessWidget {
  ViewProfilePage({super.key});

  final ProfilePagePresenter _viewProfilePresenter =
      locate<ProfilePagePresenter>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: _viewProfilePresenter,
      builder: () {
        final Employee? employee =
            _viewProfilePresenter.currentUiState.employee;
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeader(
                  theme: theme,
                  employee: _viewProfilePresenter.currentUiState.employee,
                  isPhotoEditable: true,
                  onEdit: () => _viewProfilePresenter.updateProfileImage(
                      userId: employee!.id),
                  presenter: _viewProfilePresenter,
                ),
                Padding(
                  padding: padding20,
                  child: Column(
                    children: [
                      ProfileInfoItem(
                          label: 'Name', value: employee!.name ?? ''),
                      ProfileInfoItem(
                          label: 'Email', value: employee.email ?? ''),
                      ProfileInfoItem(
                          label: 'Employee ID',
                          value: employee.employeeId ?? ''),
                      ProfileInfoItem(
                          label: 'Designation',
                          value: employee.designation ?? ''),
                      ProfileInfoItem(
                          label: 'Phone', value: employee.phoneNumber ?? ''),
                      ProfileInfoItem(
                        label: 'Joining Date',
                        value: employee.joiningDate != null
                            ? getFormattedDate(employee.joiningDate)
                            : '',
                      ),
                      ProfileInfoItem(
                        label: 'Status',
                        value: employee.employeeStatus ? 'Active' : 'Inactive',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
