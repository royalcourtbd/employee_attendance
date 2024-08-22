import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_attendance/core/services/firebase_service.dart';
import 'package:employee_attendance/domain/entities/attendance.dart';
import 'package:employee_attendance/domain/repositories/attendance_repository.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final FirebaseService _firebaseService;

  AttendanceRepositoryImpl(this._firebaseService);

  @override
  Future<void> checkIn(String userId) async {
    final now = DateTime.now();
    final attendanceRef =
        _firebaseService.firestore.collection('attendances').doc();
    final officeSettings = await _getOfficeSettings();
    final isLate = now.isAfter(
        officeSettings['startTime'].toDate().add(const Duration(minutes: 10)));

    await attendanceRef.set({
      'userId': userId,
      'checkInTime': now,
      'checkOutTime': null,
      'isLate': isLate,
    });
  }

  @override
  Future<void> checkOut(String userId) async {
    final now = DateTime.now();
    try {
      final querySnapshot = await _firebaseService.firestore
          .collection('attendances')
          .where('userId', isEqualTo: userId)
          .where('checkOutTime', isNull: true)
          .orderBy('checkInTime', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final attendanceDoc = querySnapshot.docs.first;
        final checkInTime =
            (attendanceDoc.data()['checkInTime'] as Timestamp).toDate();
        final workDuration = now.difference(checkInTime);

        await attendanceDoc.reference.update({
          'checkOutTime': now,
          'workDuration': workDuration.inSeconds,
        });
      }
    } catch (e) {
      print('Error during check out: $e');
      rethrow;
    }
  }

  @override
  Stream<Attendance?> getAttendanceStream(String userId) {
    return _firebaseService.firestore
        .collection('attendances')
        .where('userId', isEqualTo: userId)
        .orderBy('checkInTime', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        return Attendance(
          id: snapshot.docs.first.id,
          userId: data['userId'],
          checkInTime: (data['checkInTime'] as Timestamp).toDate(),
          checkOutTime: data['checkOutTime'] != null
              ? (data['checkOutTime'] as Timestamp).toDate()
              : null,
          workDuration: data['workDuration'] != null
              ? Duration(seconds: data['workDuration'])
              : null,
          isLate: data['isLate'] ?? false,
        );
      }
      return null;
    });
  }

  @override
  Stream<Map<String, dynamic>> getOfficeSettingsStream() {
    return _firebaseService.firestore
        .collection('settings')
        .doc('office')
        .snapshots()
        .map((snapshot) => snapshot.data() ?? {});
  }

  Future<Map<String, dynamic>> _getOfficeSettings() async {
    final doc = await _firebaseService.firestore
        .collection('settings')
        .doc('office')
        .get();
    return doc.data() ?? {};
  }
}
