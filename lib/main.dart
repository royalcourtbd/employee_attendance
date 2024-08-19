import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/firebase_options.dart';
import 'package:employee_attendance/presentation/employee_attendance.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

void main() async {
  await _init();
  runApp(const EmployeeAttendance());
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.getInitialMessage();
  await ServiceLocator.setup();
}
