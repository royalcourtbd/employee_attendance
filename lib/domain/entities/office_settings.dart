import 'package:equatable/equatable.dart';

class OfficeSettings extends Equatable {
  final DateTime startTime;
  final DateTime endTime;
  final int lateThreshold;
  final List<String> workDays;
  final String timeZone;
  final String ssid;
  final double latitude;
  final double longitude;

  const OfficeSettings({
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
}
