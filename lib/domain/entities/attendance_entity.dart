import 'package:employee_attendance/core/base/base_entity.dart';

class AttendanceEntity extends BaseEntity {
  final String id;
  final String userId;
  final DateTime checkInTime;
  final DateTime? checkOutTime;
  final Duration? workDuration;
  final bool isLate;

  const AttendanceEntity({
    required this.id,
    required this.userId,
    required this.checkInTime,
    this.checkOutTime,
    this.workDuration,
    required this.isLate,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        checkInTime,
        checkOutTime,
        workDuration,
        isLate,
      ];

  bool get isCheckedIn => checkOutTime == null;
}
