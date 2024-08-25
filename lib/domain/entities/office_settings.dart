import 'package:equatable/equatable.dart';

class OfficeSettings extends Equatable {
  final DateTime startTime;
  final DateTime endTime;
  final int lateThreshold;
  final List<String> workDays;
  final String timeZone;

  const OfficeSettings({
    required this.startTime,
    required this.endTime,
    required this.lateThreshold,
    required this.workDays,
    required this.timeZone,
  });

  @override
  List<Object?> get props =>
      [startTime, endTime, lateThreshold, workDays, timeZone];
}
