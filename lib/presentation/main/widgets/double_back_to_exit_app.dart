import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/presentation/main/presenter/main_page_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DoubleTapBackToExitApp extends StatefulWidget {
  final Widget child;

  const DoubleTapBackToExitApp({super.key, required this.child});

  @override
  DoubleTapBackToExitAppState createState() => DoubleTapBackToExitAppState();
}

class DoubleTapBackToExitAppState extends State<DoubleTapBackToExitApp> {
  DateTime _lastPressedAt = DateTime.now();
  late final MainPagePresenter _mainPagePresenter = locate<MainPagePresenter>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (isInvoked, result) {
        if (_mainPagePresenter.currentUiState.currentNavIndex != 0) {
          _mainPagePresenter.updateIndex(index: 0);
          return;
        }
        _handlePop(context);
      },
      child: widget.child,
    );
  }

  void _handlePop(BuildContext context) {
    final now = DateTime.now();
    if (now.difference(_lastPressedAt) > const Duration(seconds: 2)) {
      _lastPressedAt = now;

      showMessage(context: context, message: 'Press back again to exit');
    } else {
      SystemNavigator.pop();
    }
  }
}
