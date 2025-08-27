import 'package:employee_attendance/core/external_libs/loading_indicator.dart';
import 'package:flutter/material.dart';

class BuildLoadingIndicator extends StatelessWidget {
  const BuildLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: LoadingIndicator(
          theme: theme,
          color: theme.primaryColor,
          ringColor: theme.primaryColor.withValues(alpha: .5),
        ),
      ),
    );
  }
}
