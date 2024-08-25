import 'package:employee_attendance/domain/entities/attendance.dart';
import 'package:employee_attendance/domain/entities/office_settings.dart';

abstract class AttendanceRepository {
  Future<void> checkIn(String userId);
  Future<void> checkOut(String userId);
  Stream<Attendance?> getTodayAttendanceStream(String userId);
  Stream<OfficeSettings> getOfficeSettingsStream();
  Future<bool> canCheckInToday(String userId);
  Future<bool> canCheckOutToday(String userId);
  Stream<List<Attendance>> getUserAttendanceStream(String userId);
}
