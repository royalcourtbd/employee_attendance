import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_attendance/domain/entities/office_settings_entity.dart';

class OfficeSettingsModel extends OfficeSettingsEntity {
  const OfficeSettingsModel({
    required super.startTime,
    required super.endTime,
    required super.lateThreshold,
    required super.workDays,
    required super.timeZone,
    required super.ssid,
    required super.latitude,
    required super.longitude,
  });

  factory OfficeSettingsModel.fromJson(Map<String, dynamic> json) {
    return OfficeSettingsModel(
      startTime: (json['startTime'] as Timestamp).toDate(),
      endTime: (json['endTime'] as Timestamp).toDate(),
      lateThreshold: json['lateThreshold'] as int,
      workDays: List<String>.from(json['workDays']),
      timeZone: json['timeZone'] as String,
      ssid: json['ssid'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'lateThreshold': lateThreshold,
      'workDays': workDays,
      'timeZone': timeZone,
      'ssid': ssid,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory OfficeSettingsModel.fromEntity(OfficeSettingsEntity entity) {
    return OfficeSettingsModel(
      startTime: entity.startTime,
      endTime: entity.endTime,
      lateThreshold: entity.lateThreshold,
      workDays: entity.workDays,
      timeZone: entity.timeZone,
      ssid: entity.ssid,
      latitude: entity.latitude,
      longitude: entity.longitude,
    );
  }
}
