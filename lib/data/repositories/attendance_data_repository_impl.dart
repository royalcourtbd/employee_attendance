import 'package:employee_attendance/data/data_sources/remote/attendance_remote_data_source.dart';
import 'package:employee_attendance/domain/entities/all_attendance.dart';
import 'package:employee_attendance/domain/entities/attendance.dart';
import 'package:employee_attendance/domain/repositories/attendance/attendance_data_repository.dart';

class AttendanceDataRepositoryImpl extends AttendanceDataRepository {
  final AttendanceRemoteDataSource _remoteDataSource;

  AttendanceDataRepositoryImpl(this._remoteDataSource);
  @override
  Stream<Attendance?> getTodayAttendanceStreamByUserId(String userId) {
    return _remoteDataSource.getTodayAttendanceStreamByUserId(userId);
  }

  @override
  Stream<List<Attendance>> getUserAttendanceStreamByUserId(String userId) {
    return _remoteDataSource.getUserAttendanceStreamByUserId(userId);
  }

  @override
  Stream<List<AllAttendance>> streamAllAttendanceHistory() {
    return _remoteDataSource.streamAllAttendanceHistory();
  }

  @override
  Stream<List<Attendance>> streamAllTodayAttendances() {
    return _remoteDataSource.streamAllTodayAttendances();
  }
}
