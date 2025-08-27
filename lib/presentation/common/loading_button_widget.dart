import 'package:employee_attendance/core/external_libs/loading_indicator.dart';
import 'package:employee_attendance/presentation/common/primary_button.dart';
import 'package:flutter/material.dart';

class LoadingButtonWidget extends StatelessWidget {
  final bool isLoading;
  final ThemeData theme;
  final String buttonText;
  final VoidCallback onPressed;

  const LoadingButtonWidget({
    super.key,
    required this.isLoading,
    required this.theme,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingIndicator(
            theme: theme,
            color: theme.primaryColor,
            ringColor: theme.primaryColor.withValues(alpha: .5),
          )
        : PrimaryButton(
            theme: theme,
            buttonText: buttonText,
            onPressed: onPressed,
          );
  }
}
