import '../entities/attendance.dart';

abstract class AttendanceRepository {
  Future<void> checkIn(String userId);
  Future<void> checkOut(String userId);
  Future<Attendance?> getTodayAttendance(String userId);
  Stream<List<Attendance>> getAttendanceHistory(String userId);
}
