import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_attendance/domain/entities/office_settings.dart';

class OfficeSettingsModel extends OfficeSettings {
  const OfficeSettingsModel({
    required super.startTime,
    required super.endTime,
    required super.lateThreshold,
    required super.workDays,
    required super.timeZone,
    required super.ssid, // Add this
  });

  factory OfficeSettingsModel.fromJson(Map<String, dynamic> json) {
    return OfficeSettingsModel(
      startTime: (json['startTime'] as Timestamp).toDate(),
      endTime: (json['endTime'] as Timestamp).toDate(),
      lateThreshold: json['lateThreshold'] as int,
      workDays: List<String>.from(json['workDays']),
      timeZone: json['timeZone'] as String,
      ssid: json['ssid'] as String, // Add this
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'lateThreshold': lateThreshold,
      'workDays': workDays,
      'timeZone': timeZone,
      'ssid': ssid, // Add this
    };
  }

  factory OfficeSettingsModel.fromOfficeSettings(OfficeSettings settings) {
    return OfficeSettingsModel(
      startTime: settings.startTime,
      endTime: settings.endTime,
      lateThreshold: settings.lateThreshold,
      workDays: settings.workDays,
      timeZone: settings.timeZone,
      ssid: settings.ssid, // Add this
    );
  }
}
