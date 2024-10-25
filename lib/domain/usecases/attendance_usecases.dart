import 'package:employee_attendance/domain/entities/attendance.dart';
import 'package:employee_attendance/domain/entities/office_settings.dart';
import 'package:employee_attendance/domain/repositories/attendance/attendance_data_repository.dart';
import 'package:employee_attendance/domain/repositories/attendance_repository.dart';

class AttendanceUseCases {
  final AttendanceRepository _repository;
  final AttendanceDataRepository _attendanceDataRepository;

  AttendanceUseCases(this._repository, this._attendanceDataRepository);
  Stream<Attendance?> getTodayAttendanceStream(String userId) =>
      _attendanceDataRepository.getTodayAttendanceStreamByUserId(userId);

  Stream<List<Attendance>> getUserAttendanceStream(String userId) =>
      _attendanceDataRepository.getUserAttendanceStreamByUserId(userId);
  Stream<List<Attendance>> getTodaysAttendanceStream() =>
      _attendanceDataRepository.streamAllTodayAttendances();

  Future<void> updateOfficeSettings(OfficeSettings settings) =>
      _repository.updateOfficeSettings(settings);

  Stream<OfficeSettings> getOfficeSettingsStream() =>
      _repository.getOfficeSettingsStream();
}
