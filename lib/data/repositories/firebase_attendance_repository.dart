import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/attendance.dart';
import '../../domain/repositories/attendance_repository.dart';

class FirebaseAttendanceRepository implements AttendanceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> checkIn(String userId) async {
    final now = DateTime.now();
    await _firestore.collection('attendance').add({
      'userId': userId,
      'checkInTime': now,
      'isLate': _isLate(now),
      'checkOutTime': null,
    });
  }

  @override
  Future<void> checkOut(String userId) async {
    final now = DateTime.now();
    final snapshot = await _firestore
        .collection('attendance')
        .where('userId', isEqualTo: userId)
        .where('checkOutTime', isNull: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      await snapshot.docs.first.reference.update({
        'checkOutTime': now,
      });
    }
  }

  @override
  Future<Attendance?> getTodayAttendance(String userId) async {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    final snapshot = await _firestore
        .collection('attendance')
        .where('userId', isEqualTo: userId)
        .where('checkInTime', isGreaterThanOrEqualTo: todayStart)
        .where('checkInTime', isLessThan: todayEnd)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      final data = doc.data();
      return Attendance(
        id: doc.id,
        userId: data['userId'],
        checkInTime: (data['checkInTime'] as Timestamp).toDate(),
        checkOutTime: data['checkOutTime'] != null
            ? (data['checkOutTime'] as Timestamp).toDate()
            : null,
        isLate: data['isLate'],
      );
    }
    return null;
  }

  @override
  Stream<List<Attendance>> getAttendanceHistory(String userId) {
    return _firestore
        .collection('attendance')
        .where('userId', isEqualTo: userId)
        .orderBy('checkInTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return Attendance(
                id: doc.id,
                userId: data['userId'],
                checkInTime: (data['checkInTime'] as Timestamp).toDate(),
                checkOutTime: data['checkOutTime'] != null
                    ? (data['checkOutTime'] as Timestamp).toDate()
                    : null,
                isLate: data['isLate'],
              );
            }).toList());
  }

  bool _isLate(DateTime now) {
    final startTime = DateTime(now.year, now.month, now.day, 9, 0);
    return now.isAfter(startTime);
  }
}
