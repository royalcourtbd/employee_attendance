abstract class CheckInOutRepository {
  Future<void> markCheckIn(String userId);
  Future<void> markCheckOut(String userId);
  Future<bool> isCheckInAllowedToday(String userId);
  Future<bool> isCheckOutAllowedToday(String userId);
}
