// lib/domain/entities/all_attendance.dart

import 'package:employee_attendance/domain/entities/attendance_entity.dart';
import 'package:employee_attendance/domain/entities/employee_entity.dart';

class AllAttendance {
  final AttendanceEntity attendance;
  final EmployeeEntity employee;

  AllAttendance({
    required this.attendance,
    required this.employee,
  });
}
