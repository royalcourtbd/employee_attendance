import 'package:employee_attendance/core/services/firebase_service.dart';
import 'package:employee_attendance/core/static/urls.dart';
import 'package:employee_attendance/data/models/office_settings_model.dart';
import 'package:employee_attendance/domain/entities/office_settings.dart';
import 'package:employee_attendance/domain/repositories/attendance_repository.dart';
import 'package:flutter/material.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final FirebaseService _firebaseService;

  AttendanceRepositoryImpl(this._firebaseService);

  @override
  Stream<OfficeSettings> getOfficeSettingsStream() {
    return _firebaseService.firestore
        .collection(Urls.settings)
        .doc('office')
        .snapshots()
        .map((snapshot) => OfficeSettingsModel.fromJson(snapshot.data() ?? {}));
  }

  Future<OfficeSettings> _getOfficeSettings() async {
    final doc = await _firebaseService.firestore
        .collection(Urls.settings)
        .doc('office')
        .get();

    if (doc.exists && doc.data() != null) {
      return OfficeSettingsModel.fromJson(doc.data()!);
    } else {
      debugPrint('Warning: Using default office settings');
      return OfficeSettingsModel(
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 9, 0),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 17, 0),
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
  Future<void> updateOfficeSettings(OfficeSettings settings) async {
    try {
      final OfficeSettingsModel settingsModel =
          OfficeSettingsModel.fromOfficeSettings(settings);
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
