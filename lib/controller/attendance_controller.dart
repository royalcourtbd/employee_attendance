import 'package:employee_attendance/core/utility/network_util.dart';
import 'package:get/get.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../../data/repositories/firebase_attendance_repository.dart';

class AttendanceController extends GetxController {
  final AttendanceRepository _attendanceRepository =
      FirebaseAttendanceRepository();
  final NetworkUtil _networkUtil = NetworkUtil();

  final _status = 'Not checked in'.obs;
  String get status => _status.value;

  final _canCheckIn = true.obs;
  bool get canCheckIn => _canCheckIn.value;

  final _canCheckOut = false.obs;
  bool get canCheckOut => _canCheckOut.value;

  @override
  void onInit() {
    super.onInit();
    _checkTodayAttendance();
  }

  void _checkTodayAttendance() async {
    const userId = 'current_user_id'; // Replace with actual user ID
    final attendance = await _attendanceRepository.getTodayAttendance(userId);
    if (attendance != null) {
      if (attendance.checkOutTime == null) {
        _canCheckIn.value = false;
        _canCheckOut.value = true;
        _status.value = 'Checked in';
      } else {
        _canCheckIn.value = false;
        _canCheckOut.value = false;
        _status.value = 'Checked out for today';
      }
    }
  }

  void checkIn() async {
    bool isConnectedToOfficeWifi = await _networkUtil.isConnectedToOfficeWifi();
    if (!isConnectedToOfficeWifi) {
      Get.snackbar(
          'Error', 'You must be connected to the office WiFi to check in',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    const userId = 'current_user_id'; // Replace with actual user ID
    try {
      await _attendanceRepository.checkIn(userId);
      _status.value = 'Checked in';
      _canCheckIn.value = false;
      _canCheckOut.value = true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to check in',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void checkOut() async {
    const userId = 'current_user_id'; // Replace with actual user ID
    try {
      await _attendanceRepository.checkOut(userId);
      _status.value = 'Checked out';
      _canCheckIn.value = false;
      _canCheckOut.value = false;
    } catch (e) {
      Get.snackbar('Error', 'Failed to check out',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
