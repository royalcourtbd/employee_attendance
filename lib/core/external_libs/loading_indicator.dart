import 'package:employee_attendance/core/external_libs/loading_animation/ink_drop_loading_animation.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator(
      {super.key, this.ringColor, this.color, required this.theme});

  final Color? color;
  final Color? ringColor;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkDropLoading(
        size: 30,
        ringColor: ringColor,
        color: color ?? theme.primaryColor,
      ),
    );
  }
}