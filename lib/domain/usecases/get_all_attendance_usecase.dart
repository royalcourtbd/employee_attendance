// lib/domain/usecases/get_all_attendance_usecase.dart
import 'package:employee_attendance/domain/entities/all_attendance.dart';
import 'package:employee_attendance/domain/repositories/attendance_repository.dart';

class GetAllAttendanceUseCase {
  final AttendanceRepository _repository;

  GetAllAttendanceUseCase(this._repository);

  Stream<List<AllAttendance>> getAllAttendancesStream() =>
      _repository.getAllAttendancesStream();
}
