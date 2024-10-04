import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const SettingsItem({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
