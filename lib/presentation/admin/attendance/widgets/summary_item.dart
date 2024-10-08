import 'package:flutter/material.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(
      {super.key,
      required this.label,
      required this.value,
      required this.theme});
  final String label;
  final String value;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: theme.textTheme.bodySmall),
        Text(value,
            style: theme.textTheme.titleLarge
                ?.copyWith(color: theme.primaryColor)),
      ],
    );
  }
}
