import 'package:employee_attendance/domain/entities/all_attendance.dart';
import 'package:employee_attendance/domain/entities/attendance.dart';

abstract class AttendanceDataRepository {
  Stream<Attendance?> getTodayAttendanceStreamByUserId(String userId);
  Stream<List<Attendance>> streamAllTodayAttendances();
  Stream<List<Attendance>> getUserAttendanceStreamByUserId(String userId);
  Stream<List<AllAttendance>> streamAllAttendanceHistory();
}
