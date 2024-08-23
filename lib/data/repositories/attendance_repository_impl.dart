import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_attendance/core/services/firebase_service.dart';
import 'package:employee_attendance/data/models/attendance_model.dart';
import 'package:employee_attendance/domain/entities/attendance.dart';
import 'package:employee_attendance/domain/repositories/attendance_repository.dart';
import 'package:flutter/material.dart';

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

    final newAttendance = AttendanceModel(
      id: attendanceRef.id,
      userId: userId,
      checkInTime: now,
      checkOutTime: null,
      workDuration: null,
      isLate: isLate,
    );

    await attendanceRef.set(newAttendance.toJson());
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
      debugPrint('Error during check out: $e');
      rethrow;
    }
  }

  @override
  Stream<Attendance?> getTodayAttendanceStream(String userId) {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return _firebaseService.firestore
        .collection('attendances')
        .where('userId', isEqualTo: userId)
        .where('checkInTime', isGreaterThanOrEqualTo: startOfDay)
        .where('checkInTime', isLessThan: endOfDay)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        data['id'] = snapshot.docs.first.id; // Add this line
        return AttendanceModel.fromJson(data);
      }
      return null;
    });
  }

  @override
  Future<bool> canCheckInToday(String userId) async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final querySnapshot = await _firebaseService.firestore
        .collection('attendances')
        .where('userId', isEqualTo: userId)
        .where('checkInTime', isGreaterThanOrEqualTo: startOfDay)
        .where('checkInTime', isLessThan: endOfDay)
        .get();

    return querySnapshot.docs.isEmpty;
  }

  @override
  Future<bool> canCheckOutToday(String userId) async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final querySnapshot = await _firebaseService.firestore
        .collection('attendances')
        .where('userId', isEqualTo: userId)
        .where('checkInTime', isGreaterThanOrEqualTo: startOfDay)
        .where('checkInTime', isLessThan: endOfDay)
        .where('checkOutTime', isNull: true)
        .get();

    return querySnapshot.docs.isNotEmpty;
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
