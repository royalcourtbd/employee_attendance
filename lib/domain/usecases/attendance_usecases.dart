import 'package:employee_attendance/domain/entities/attendance.dart';
import 'package:employee_attendance/domain/repositories/attendance_repository.dart';

class AttendanceUseCases {
  final AttendanceRepository _repository;

  AttendanceUseCases(this._repository);

  Future<void> checkIn(String userId) => _repository.checkIn(userId);
  Future<void> checkOut(String userId) => _repository.checkOut(userId);
  Stream<Attendance?> getTodayAttendanceStream(String userId) =>
      _repository.getTodayAttendanceStream(userId);
  Stream<Map<String, dynamic>> getOfficeSettingsStream() =>
      _repository.getOfficeSettingsStream();

  // নতুন মেথড যোগ করুন
  Future<bool> canCheckInToday(String userId) =>
      _repository.canCheckInToday(userId);

  // নতুন মেথড যোগ করুন
  Future<bool> canCheckOutToday(String userId) =>
      _repository.canCheckOutToday(userId);
}
