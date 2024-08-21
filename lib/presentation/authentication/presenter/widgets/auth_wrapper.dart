import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/loading_indicator.dart';
import 'package:employee_attendance/data/repositories/user_repository_impl.dart';
import 'package:employee_attendance/domain/repositories/user_repository.dart';
import 'package:employee_attendance/presentation/admin/ui/admin_dashboard_page.dart';
import 'package:employee_attendance/presentation/login/ui/login_page.dart';
import 'package:employee_attendance/presentation/main/ui/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {
  final UserRepository _userRepository = locate<UserRepository>();

  AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return StreamBuilder<firebase_auth.User?>(
      stream: (_userRepository as UserRepositoryImpl).authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return LoginPage();
          } else {
            return FutureBuilder(
              future: _userRepository.fetchUserData(user.uid),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.done) {
                  final appUser = userSnapshot.data;
                  if (appUser != null) {
                    if (appUser.role == 'admin') {
                      return const AdminDashboardPage();
                    } else {
                      return MainPage();
                    }
                  } else {
                    _userRepository.logout();
                    return LoginPage();
                  }
                }
                return Scaffold(
                  body: Center(
                    child: LoadingIndicator(
                      theme: theme,
                      color: theme.primaryColor,
                      ringColor: theme.primaryColor.withOpacity(0.5),
                    ),
                  ),
                );
              },
            );
          }
        }
        return LoadingIndicator(
          theme: theme,
          color: theme.primaryColor,
          ringColor: theme.primaryColor.withOpacity(0.5),
        );
      },
    );
  }
}
