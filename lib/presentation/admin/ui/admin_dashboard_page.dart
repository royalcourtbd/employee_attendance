import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/presentation/authentication/presenter/auth_presenter.dart';
import 'package:flutter/material.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async => locate<AuthPresenter>().signOut(),
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome to the Admin Dashboard'),
      ),
    );
  }
}
