// lib/presentation/authentication/presenter/widgets/auth_wrapper.dart

import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/presentation/authentication/widgets/auth_content.dart';
import 'package:employee_attendance/presentation/authentication/presenter/auth_wrapper_presenter.dart';
import 'package:employee_attendance/presentation/authentication/widgets/build_loading_indicator.dart';
import 'package:flutter/material.dart';

class AuthWrapperPage extends StatelessWidget {
  AuthWrapperPage({super.key});

  final AuthWrapperPresenter _presenter = locate<AuthWrapperPresenter>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: _presenter.authStateStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return AuthContent(authState: snapshot.data);
        }
        return const BuildLoadingIndicator();
      },
    );
  }
}
