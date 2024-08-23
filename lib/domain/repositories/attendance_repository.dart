import 'package:employee_attendance/domain/entities/attendance.dart';

abstract class AttendanceRepository {
  Future<void> checkIn(String userId);
  Future<void> checkOut(String userId);
  Stream<Attendance?> getTodayAttendanceStream(String userId);
  Stream<Map<String, dynamic>> getOfficeSettingsStream();
  Future<bool> canCheckInToday(String userId);
  Future<bool> canCheckOutToday(String userId);
}
