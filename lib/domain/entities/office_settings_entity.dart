import 'package:employee_attendance/core/base/base_entity.dart';

class OfficeSettingsEntity extends BaseEntity {
  final DateTime startTime;
  final DateTime endTime;
  final int lateThreshold;
  final List<String> workDays;
  final String timeZone;
  final String ssid;
  final double latitude;
  final double longitude;

  const OfficeSettingsEntity({
    required this.startTime,
    required this.endTime,
    required this.lateThreshold,
    required this.workDays,
    required this.timeZone,
    required this.ssid,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
        startTime,
        endTime,
        lateThreshold,
        workDays,
        timeZone,
        ssid,
        latitude,
        longitude,
      ];

  OfficeSettingsEntity copyWith({
    DateTime? startTime,
    DateTime? endTime,
    int? lateThreshold,
    List<String>? workDays,
    String? timeZone,
    String? ssid,
    double? latitude,
    double? longitude,
  }) {
    return OfficeSettingsEntity(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      lateThreshold: lateThreshold ?? this.lateThreshold,
      workDays: workDays ?? this.workDays,
      timeZone: timeZone ?? this.timeZone,
      ssid: ssid ?? this.ssid,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
