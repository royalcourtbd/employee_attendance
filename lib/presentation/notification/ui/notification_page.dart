import 'package:flutter/material.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({super.key});

  @override
  NotificationListScreenState createState() => NotificationListScreenState();
}

class NotificationListScreenState extends State<NotificationListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
    );
  }
}
