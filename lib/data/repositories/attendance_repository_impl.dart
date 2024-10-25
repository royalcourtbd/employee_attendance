import 'package:employee_attendance/core/services/firebase_service.dart';
import 'package:employee_attendance/core/static/urls.dart';
import 'package:employee_attendance/data/models/office_settings_model.dart';
import 'package:employee_attendance/domain/entities/office_settings_entity.dart';
import 'package:employee_attendance/domain/repositories/attendance_repository.dart';
import 'package:employee_attendance/domain/service/time_service.dart';
import 'package:flutter/material.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final FirebaseService _firebaseService;
  final TimeService _timeService;

  AttendanceRepositoryImpl(this._firebaseService, this._timeService);

  @override
  Stream<OfficeSettingsEntity> getOfficeSettingsStream() {
    return _firebaseService.firestore
        .collection(Urls.settings)
        .doc('office')
        .snapshots()
        .map((snapshot) => OfficeSettingsModel.fromJson(snapshot.data() ?? {}));
  }

  Future<OfficeSettingsEntity> _getOfficeSettings() async {
    final doc = await _firebaseService.firestore
        .collection(Urls.settings)
        .doc('office')
        .get();

    if (doc.exists && doc.data() != null) {
      return OfficeSettingsModel.fromJson(doc.data()!);
    } else {
      debugPrint('Warning: Using default office settings');
      final DateTime today = _timeService.getCurrentTime();
      return OfficeSettingsModel(
        startTime: DateTime(
          today.year,
          today.month,
          today.day,
          9,
          0,
        ),
        endTime: DateTime(
          today.year,
          today.month,
          today.day,
          17,
          0,
        ),
        lateThreshold: 10,
        workDays: const [
          'Sunday',
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday'
        ],
        timeZone: 'Asia/Dhaka',
        ssid: 'DefaultSSID', // Add this
        latitude: 23.8103,
        longitude: 90.4125,
      );
    }
  }

  @override
  Future<void> updateOfficeSettings(OfficeSettingsEntity settings) async {
    try {
      final OfficeSettingsModel settingsModel =
          OfficeSettingsModel.fromEntity(settings);
      await _firebaseService.firestore
          .collection(Urls.settings)
          .doc('office')
          .set(settingsModel.toJson());
    } catch (e) {
      debugPrint('Error updating office settings: $e');
      throw Exception('Failed to update office settings');
    }
  }
}
