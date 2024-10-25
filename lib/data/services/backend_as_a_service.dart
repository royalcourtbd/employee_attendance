import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_attendance/core/services/firebase_service.dart';
import 'package:employee_attendance/core/static/urls.dart';
import 'package:employee_attendance/data/models/attendance_model.dart';
import 'package:employee_attendance/data/models/employee_user_model.dart';
import 'package:employee_attendance/data/models/office_settings_model.dart';
import 'package:employee_attendance/domain/entities/all_attendance.dart';
import 'package:employee_attendance/domain/entities/attendance.dart';
import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class BackendAsAService {
  final FirebaseService _firebaseService;
  BackendAsAService(this._firebaseService);

  firebase_auth.User? get currentUser => _firebaseService.auth.currentUser;

  Future<Either<String, Employee?>> signIn(
          String email, String password) async =>
      _signIn(email, password);

  Future<void> signOut() async => _signOut();

  Future<void> changePassword(String newPassword) async =>
      _changePassword(newPassword);

  Future<void> markCheckIn(String userId) async => _markCheckIn(userId);

  Future<void> markCheckOut(String userId) async => _markCheckOut(userId);

  Future<bool> isCheckInAllowedToday(String userId) async =>
      _isCheckInAllowedToday(userId);

  Future<bool> isCheckOutAllowedToday(String userId) async =>
      _isCheckOutAllowedToday(userId);

  Future<Either<String, Employee?>> _signIn(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseService.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      //     final Employee? user = await fetchUserData(userCredential.user!.uid);
      //     return Right(user);

      final DocumentSnapshot<Map<String, dynamic>> doc = await _firebaseService
          .firestore
          .collection(Urls.employees)
          .doc(userCredential.user!.uid)
          .get();

      if (doc.exists) {
        final EmployeeUserModel employee =
            EmployeeUserModel.fromJson(doc.data()!);
        return Right(employee);
      }
      return const Right(null);
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const Left('No user found for this email');
      } else if (e.code == 'wrong-password') {
        return const Left('Wrong password provided for this user');
      } else {
        return const Left('Invalid email');
      }
    } on SocketException catch (_) {
      return const Left('No internet connection');
    } on TimeoutException catch (_) {
      return const Left('Request timed out');
    } catch (e) {
      return const Left('An error occurred');
    }
  }

  Future<void> _signOut() async {
    await _firebaseService.auth.signOut();
  }

  Future<void> _changePassword(String newPassword) async {
    try {
      if (currentUser != null) {
        await currentUser!.updatePassword(newPassword);
      } else {
        throw Exception('No user is currently signed in.');
      }
    } catch (e) {
      throw Exception('Failed to change password: $e');
    }
  }

  Future<void> _markCheckIn(String userId) async {
    try {
      final DateTime now = DateTime.now();
      final DocumentReference<Map<String, dynamic>> attendanceRef =
          _firebaseService.firestore.collection(Urls.attendances).doc();

      final OfficeSettingsModel officeSettings = await _firebaseService
          .firestore
          .collection(Urls.settings)
          .doc('office')
          .get()
          .then((doc) => OfficeSettingsModel.fromJson(doc.data()!));

      // আপনার office start time
      final DateTime officeStartTime = officeSettings.startTime;

      // Late threshold থেকে grace period নেওয়া হচ্ছে
      final int gracePeriodMinutes = officeSettings.lateThreshold;

      // Grace period যোগ করে deadline time তৈরি
      final DateTime lateDeadline = DateTime(
        officeStartTime.year,
        officeStartTime.month,
        officeStartTime.day,
        officeStartTime.hour,
        officeStartTime.minute + gracePeriodMinutes,
      );

      // Check if current time is after late deadline
      final bool isLate = now.isAfter(lateDeadline);

      final AttendanceModel newAttendance = AttendanceModel(
        id: attendanceRef.id,
        userId: userId,
        checkInTime: now,
        checkOutTime: null,
        workDuration: null,
        isLate: isLate,
      );

      await attendanceRef.set(newAttendance.toJson());
    } catch (e) {
      throw Exception('Failed to check in: $e');
    }
  }

  Future<void> _markCheckOut(String userId) async {
    final DateTime now = DateTime.now();
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseService.firestore
              .collection(Urls.attendances)
              .where('userId', isEqualTo: userId)
              .where('checkOutTime', isNull: true)
              .orderBy('checkInTime', descending: true)
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        final QueryDocumentSnapshot<Map<String, dynamic>> attendanceDoc =
            querySnapshot.docs.first;
        final DateTime checkInTime =
            (attendanceDoc.data()['checkInTime'] as Timestamp).toDate();
        final workDuration = now.difference(checkInTime);

        await attendanceDoc.reference.update({
          'checkOutTime': now,
          'workDuration': workDuration.inSeconds,
        });
      }
    } catch (e) {
      log('Error during check out: $e');
      rethrow;
    }
  }

  Future<bool> _isCheckInAllowedToday(String userId) async {
    final DateTime today = DateTime.now();
    final DateTime startOfDay = DateTime(today.year, today.month, today.day);
    final DateTime endOfDay = startOfDay.add(const Duration(days: 1));

    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseService.firestore
            .collection(Urls.attendances)
            .where('userId', isEqualTo: userId)
            .where('checkInTime', isGreaterThanOrEqualTo: startOfDay)
            .where('checkInTime', isLessThan: endOfDay)
            .get();

    return querySnapshot.docs.isEmpty;
  }

  Future<bool> _isCheckOutAllowedToday(String userId) async {
    final DateTime today = DateTime.now();
    final DateTime startOfDay = DateTime(today.year, today.month, today.day);
    final DateTime endOfDay = startOfDay.add(const Duration(days: 1));

    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseService.firestore
            .collection(Urls.attendances)
            .where('userId', isEqualTo: userId)
            .where('checkInTime', isGreaterThanOrEqualTo: startOfDay)
            .where('checkInTime', isLessThan: endOfDay)
            .where('checkOutTime', isNull: true)
            .get();

    return querySnapshot.docs.isNotEmpty;
  }

  Stream<Attendance?> getTodayAttendanceStreamByUserId(String userId) {
    final DateTime now = DateTime.now();
    final DateTime startOfDay = DateTime(now.year, now.month, now.day);
    final DateTime endOfDay = startOfDay.add(const Duration(days: 1));

    return _firebaseService.firestore
        .collection(Urls.attendances)
        .where('userId', isEqualTo: userId)
        .where('checkInTime', isGreaterThanOrEqualTo: startOfDay)
        .where('checkInTime', isLessThan: endOfDay)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final QueryDocumentSnapshot<Map<String, dynamic>> doc =
            snapshot.docs.first;
        return AttendanceModel.fromJson(doc.data());
      }
      return null;
    });
  }

  Stream<List<Attendance>> streamAllTodayAttendances() {
    final DateTime now = DateTime.now();
    final DateTime startOfDay = DateTime(now.year, now.month, now.day);
    final DateTime endOfDay = startOfDay.add(const Duration(days: 1));

    return _firebaseService.firestore
        .collection(Urls.attendances)
        .where('checkInTime', isGreaterThanOrEqualTo: startOfDay)
        .where('checkInTime', isLessThan: endOfDay)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return AttendanceModel.fromJson(doc.data());
      }).toList();
    });
  }

  Stream<List<Attendance>> getUserAttendanceStreamByUserId(String userId) {
    return _firebaseService.firestore
        .collection(Urls.attendances)
        .where('userId', isEqualTo: userId)
        .orderBy('checkInTime', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return AttendanceModel.fromJson(doc.data());
      }).toList();
    });
  }

  Stream<List<AllAttendance>> streamAllAttendanceHistory() {
    return _firebaseService.firestore
        .collection(Urls.attendances)
        .snapshots()
        .asyncMap((snapshot) async {
      final List<AllAttendance> allAttendances = [];
      for (final doc in snapshot.docs) {
        final AttendanceModel attendance = AttendanceModel.fromJson(doc.data());
        final EmployeeUserModel employee = await _firebaseService.firestore
            .collection(Urls.employees)
            .doc(attendance.userId)
            .get()
            .then((doc) => EmployeeUserModel.fromJson(doc.data()!));

        allAttendances.add(AllAttendance(
          employee: employee,
          attendance: attendance,
        ));
      }
      return allAttendances;
    });
  }
}
