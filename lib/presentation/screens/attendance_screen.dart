import 'package:employee_attendance/controller/attendance_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'attendance_history_screen.dart';

class AttendanceScreen extends StatelessWidget {
  final AttendanceController controller = Get.put(AttendanceController());

  AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text('Status: ${controller.status}',
                style: Theme.of(context).textTheme.bodyMedium)),
            const SizedBox(height: 20),
            Obx(() => ElevatedButton(
                  onPressed:
                      controller.canCheckIn ? () => controller.checkIn() : null,
                  child: const Text('Check In'),
                )),
            const SizedBox(height: 20),
            Obx(() => ElevatedButton(
                  onPressed: controller.canCheckOut
                      ? () => controller.checkOut()
                      : null,
                  child: const Text('Check Out'),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.to(() => const AttendanceHistoryScreen()),
              child: const Text('View History'),
            ),
          ],
        ),
      ),
    );
  }
}
