import 'package:employee_attendance/domain/repositories/attendance/check_in_out_repository.dart';

class ChechInOutUseCase {
  final CheckInOutRepository _repository;

  ChechInOutUseCase(this._repository);

  Future<bool> isCheckInAllowedToday(String userId) async {
    final result = await _repository.isCheckInAllowedToday(userId);
    return result;
  }

  Future<bool> isCheckOutAllowedToday(String userId) async {
    final result = await _repository.isCheckOutAllowedToday(userId);
    return result;
  }

  Future<void> markCheckIn(String userId) async {
    await _repository.markCheckIn(userId);
  }

  Future<void> markCheckOut(String userId) async {
    await _repository.markCheckOut(userId);
  }
}
