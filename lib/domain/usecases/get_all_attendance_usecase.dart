// lib/domain/usecases/get_all_attendance_usecase.dart
import 'package:employee_attendance/domain/entities/all_attendance.dart';
import 'package:employee_attendance/domain/repositories/attendance/attendance_data_repository.dart';

class GetAllAttendanceUseCase {
  final AttendanceDataRepository _repository;

  GetAllAttendanceUseCase(this._repository);

  Stream<List<AllAttendance>> getAllAttendancesStream() =>
      _repository.streamAllAttendanceHistory();
}
