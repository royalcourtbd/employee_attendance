import 'package:employee_attendance/domain/entities/attendance_entity.dart';
import 'package:employee_attendance/domain/entities/office_settings_entity.dart';
import 'package:employee_attendance/domain/repositories/attendance/attendance_data_repository.dart';
import 'package:employee_attendance/domain/repositories/attendance_repository.dart';

class AttendanceUseCases {
  final AttendanceRepository _repository;
  final AttendanceDataRepository _attendanceDataRepository;

  AttendanceUseCases(this._repository, this._attendanceDataRepository);
  Stream<AttendanceEntity?> getTodayAttendanceStream(String userId) =>
      _attendanceDataRepository.getTodayAttendanceStreamByUserId(userId);

  Stream<List<AttendanceEntity>> getUserAttendanceStream(String userId) =>
      _attendanceDataRepository.getUserAttendanceStreamByUserId(userId);
  Stream<List<AttendanceEntity>> getTodaysAttendanceStream() =>
      _attendanceDataRepository.streamAllTodayAttendances();

  Future<void> updateOfficeSettings(OfficeSettingsEntity settings) =>
      _repository.updateOfficeSettings(settings);

  Stream<OfficeSettingsEntity> getOfficeSettingsStream() =>
      _repository.getOfficeSettingsStream();
}
