import 'package:employee_attendance/data/data_sources/remote/check_in_out_remote_data_source.dart';
import 'package:employee_attendance/domain/repositories/attendance/check_in_out_repository.dart';

class CheckInOutRepositoryImpl extends CheckInOutRepository {
  final CheckInOutRemoteDataSource _checkInOutRemoteDataSource;

  CheckInOutRepositoryImpl(this._checkInOutRemoteDataSource);

  @override
  Future<bool> isCheckInAllowedToday(String userId) {
    final Future<bool> result =
        _checkInOutRemoteDataSource.isCheckInAllowedToday(userId);

    return result;
  }

  @override
  Future<bool> isCheckOutAllowedToday(String userId) {
    final Future<bool> result =
        _checkInOutRemoteDataSource.isCheckOutAllowedToday(userId);

    return result;
  }

  @override
  Future<void> markCheckIn(String userId) {
    final Future<void> result = _checkInOutRemoteDataSource.markCheckIn(userId);
    return result;
  }

  @override
  Future<void> markCheckOut(String userId) {
    final Future<void> result =
        _checkInOutRemoteDataSource.markCheckOut(userId);
    return result;
  }
}
