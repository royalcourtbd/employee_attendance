// lib/domain/entities/all_attendance.dart

import 'package:employee_attendance/domain/entities/attendance.dart';
import 'package:employee_attendance/domain/entities/employee.dart';

class AllAttendance {
  final Attendance attendance;
  final Employee employee;

  AllAttendance({
    required this.attendance,
    required this.employee,
  });
}
