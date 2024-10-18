// lib/presentation/authentication/widgets/auth_content.dart

import 'package:employee_attendance/presentation/admin/dashboard/ui/admin_dashboard_page.dart';
import 'package:employee_attendance/presentation/authentication/presenter/auth_wrapper_presenter.dart';
import 'package:employee_attendance/presentation/authentication/widgets/build_loading_indicator.dart';
import 'package:employee_attendance/presentation/login/ui/login_page.dart';
import 'package:employee_attendance/presentation/main/ui/main_page.dart';
import 'package:flutter/material.dart';

class AuthContent extends StatelessWidget {
  final AuthState? authState;

  const AuthContent({super.key, required this.authState});

  @override
  Widget build(BuildContext context) {
    switch (authState) {
      case AuthState.loggedOut:
        return LoginPage();
      case AuthState.loggedInAdmin:
        return AdminDashboardPage();
      case AuthState.loggedInEmployee:
        return MainPage();
      case AuthState.loading:
      default:
        return const BuildLoadingIndicator();
    }
  }
}
