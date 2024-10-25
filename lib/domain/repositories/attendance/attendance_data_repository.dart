import 'package:employee_attendance/domain/entities/all_attendance.dart';
import 'package:employee_attendance/domain/entities/attendance_entity.dart';

abstract class AttendanceDataRepository {
  Stream<AttendanceEntity?> getTodayAttendanceStreamByUserId(String userId);
  Stream<List<AttendanceEntity>> streamAllTodayAttendances();
  Stream<List<AttendanceEntity>> getUserAttendanceStreamByUserId(String userId);
  Stream<List<AllAttendance>> streamAllAttendanceHistory();
}
