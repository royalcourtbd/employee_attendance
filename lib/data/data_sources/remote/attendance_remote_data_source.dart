import 'package:employee_attendance/data/services/backend_as_a_service.dart';
import 'package:employee_attendance/domain/entities/all_attendance.dart';
import 'package:employee_attendance/domain/entities/attendance.dart';

class AttendanceRemoteDataSource {
  final BackendAsAService _backendAsAService;

  AttendanceRemoteDataSource(this._backendAsAService);

  Stream<Attendance?> getTodayAttendanceStreamByUserId(String userId) {
    return _backendAsAService.getTodayAttendanceStreamByUserId(userId);
  }

  Stream<List<Attendance>> streamAllTodayAttendances() {
    return _backendAsAService.streamAllTodayAttendances();
  }

  Stream<List<Attendance>> getUserAttendanceStreamByUserId(String userId) {
    return _backendAsAService.getUserAttendanceStreamByUserId(userId);
  }

  Stream<List<AllAttendance>> streamAllAttendanceHistory() {
    return _backendAsAService.streamAllAttendanceHistory();
  }
}
