import 'package:employee_attendance/data/services/backend_as_a_service.dart';

class CheckInOutRemoteDataSource {
  final BackendAsAService _backendAsAService;

  CheckInOutRemoteDataSource(this._backendAsAService);

  Future<bool> isCheckInAllowedToday(String userId) async {
    return await _backendAsAService.isCheckInAllowedToday(userId);
  }

  Future<bool> isCheckOutAllowedToday(String userId) async {
    return await _backendAsAService.isCheckOutAllowedToday(userId);
  }

  Future<void> markCheckIn(String userId) async {
    await _backendAsAService.markCheckIn(userId);
  }

  Future<void> markCheckOut(String userId) async {
    await _backendAsAService.markCheckOut(userId);
  }
}
