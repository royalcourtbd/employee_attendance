import 'package:employee_attendance/domain/entities/attendance.dart';

abstract class AttendanceRepository {
  Future<void> checkIn(String userId);
  Future<void> checkOut(String userId);
  Stream<Attendance?> getAttendanceStream(String userId);
  Stream<Map<String, dynamic>> getOfficeSettingsStream();
}
