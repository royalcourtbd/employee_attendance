import 'dart:async';

import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/splash/splash_screen.dart';
import 'package:employee_attendance/core/services/app_bootstrap.dart';
import 'package:employee_attendance/firebase_options.dart';
import 'package:employee_attendance/presentation/employee_attendance.dart';
import 'package:employee_attendance/presentation/profile/presenter/profile_page_presenter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() async {
  await SplashScreen.show();
  final AppBootstrapResult bootstrapResult = await _init();

  final employee = bootstrapResult.employee;
  if (employee != null &&
      bootstrapResult.destination == AppDestination.employeeHome) {
    locate<ProfilePagePresenter>().initializeUser(employee);
  }

  runApp(
    EmployeeAttendance(initialDestination: bootstrapResult.destination),
  );

  WidgetsBinding.instance.addPostFrameCallback((_) {
    SplashScreen.hide();
  });

  unawaited(_loadInitialFirebaseMessage());
}

Future<AppBootstrapResult> _init() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ServiceLocator.setup();
  return resolveInitialAppDestination();
}

Future<void> _loadInitialFirebaseMessage() async {
  try {
    await FirebaseMessaging.instance.getInitialMessage();
  } catch (_) {
    // Initial-message lookup must not block or fail app startup.
  }
}
