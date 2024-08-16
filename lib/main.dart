import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/presentation/employee_attendance.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _init();
  runApp(const EmployeeAttendance());
}

Future<void> _init() async {
  await ServiceLocator.setup();
}
