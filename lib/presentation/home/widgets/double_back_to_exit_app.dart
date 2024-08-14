import 'package:employee_attendance/core/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DoubleBackToExitApp extends StatefulWidget {
  final Widget child;

  const DoubleBackToExitApp({super.key, required this.child});

  @override
  DoubleBackToExitAppState createState() => DoubleBackToExitAppState();
}

class DoubleBackToExitAppState extends State<DoubleBackToExitApp> {
  DateTime _lastPressedAt = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
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
