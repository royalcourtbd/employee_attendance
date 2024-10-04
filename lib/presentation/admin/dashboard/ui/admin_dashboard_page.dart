import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/presentation/admin/employee/ui/employees_page.dart';
import 'package:employee_attendance/presentation/admin/settings/ui/settings_page.dart';
import 'package:employee_attendance/presentation/admin/dashboard/widgets/admin_dashboard_grid_item.dart';
import 'package:employee_attendance/presentation/login/presenter/login_page_presenter.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            padding: const EdgeInsets.all(16.0),
            children: [
              AdminDashboardGridItem(
                title: 'Employees',
                icon: Icons.people,
                onTap: () => Get.to(() => EmployeesPage()),
              ),
              AdminDashboardGridItem(
                title: 'Settings',
                icon: Icons.settings,
                onTap: () => Get.to(SettingsPage()),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () => locate<LoginPagePresenter>().createDemoUser(),
            child: const Text('Add user'),
          )
        ],
      ),
    );
  }
}
