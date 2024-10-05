import 'package:employee_attendance/domain/entities/attendance.dart';
import 'package:employee_attendance/domain/entities/office_settings.dart';
import 'package:employee_attendance/domain/repositories/attendance_repository.dart';

class AttendanceUseCases {
  final AttendanceRepository _repository;

  AttendanceUseCases(this._repository);

  Future<void> checkIn(String userId) => _repository.checkIn(userId);
  Future<void> checkOut(String userId) => _repository.checkOut(userId);
  Stream<Attendance?> getTodayAttendanceStream(String userId) =>
      _repository.getTodayAttendanceStream(userId);
  Stream<OfficeSettings> getOfficeSettingsStream() =>
      _repository.getOfficeSettingsStream();

  Future<bool> canCheckInToday(String userId) =>
      _repository.canCheckInToday(userId);

  Future<bool> canCheckOutToday(String userId) =>
      _repository.canCheckOutToday(userId);

  Stream<List<Attendance>> getUserAttendanceStream(String userId) =>
      _repository.getUserAttendanceStream(userId);
  Future<List<Attendance>> getTodaysAttendance() =>
      _repository.getTodaysAttendance();

  Future<void> updateOfficeSettings(OfficeSettings settings) =>
      _repository.updateOfficeSettings(settings);
}
