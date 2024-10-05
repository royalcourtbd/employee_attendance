import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/presentation/admin/attendance/ui/todays_attendance_page.dart';
import 'package:employee_attendance/presentation/admin/dashboard/presenter/admin_dashboard_presenter.dart';
import 'package:employee_attendance/presentation/admin/employee/ui/employees_page.dart';
import 'package:employee_attendance/presentation/admin/settings/ui/settings_page.dart';
import 'package:employee_attendance/presentation/admin/dashboard/widgets/admin_dashboard_grid_item.dart';
import 'package:employee_attendance/presentation/login/presenter/login_page_presenter.dart';
import 'package:employee_attendance/presentation/profile/widgets/log_out_dialog.dart';
import 'package:flutter/material.dart';

class AdminDashboardPage extends StatelessWidget {
  AdminDashboardPage({super.key});
  final AdminDashboardPresenter _adminDashboardPresenter =
      locate<AdminDashboardPresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => LogOutDialog.show(
              context: context,
              title: 'Sign Out',
              onRemove: () => _adminDashboardPresenter.logout(),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            padding: padding15,
            crossAxisSpacing: fifteenPx,
            mainAxisSpacing: fifteenPx,
            children: [
              AdminDashboardGridItem(
                title: 'Employees',
                icon: Icons.people,
                theme: theme,
                onTap: () => context.navigatorPush(EmployeesPage()),
              ),
              AdminDashboardGridItem(
                title: 'Today\'s Attendance',
                icon: Icons.assignment_turned_in_sharp,
                theme: theme,
                onTap: () => context.navigatorPush(TodaysAttendancePage()),
              ),
              AdminDashboardGridItem(
                title: 'Settings',
                icon: Icons.settings,
                theme: theme,
                onTap: () => context.navigatorPush(SettingsPage()),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () => locate<LoginPagePresenter>().createDemoUser(),
            child: const Text('Add user'),
          ),
        ],
      ),
    );
  }
}
