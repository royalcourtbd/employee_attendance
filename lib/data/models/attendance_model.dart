import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_attendance/domain/entities/attendance_entity.dart';

class AttendanceModel extends AttendanceEntity {
  const AttendanceModel({
    required super.id,
    required super.userId,
    required super.checkInTime,
    super.checkOutTime,
    super.workDuration,
    required super.isLate,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      checkInTime: json['checkInTime'] != null
          ? (json['checkInTime'] as Timestamp).toDate()
          : DateTime.now(),
      checkOutTime: json['checkOutTime'] != null
          ? (json['checkOutTime'] as Timestamp).toDate()
          : null,
      workDuration: json['workDuration'] != null
          ? Duration(seconds: json['workDuration'] as int)
          : null,
      isLate: json['isLate'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'checkInTime': Timestamp.fromDate(checkInTime),
      'checkOutTime':
          checkOutTime != null ? Timestamp.fromDate(checkOutTime!) : null,
      'workDuration': workDuration?.inSeconds,
      'isLate': isLate,
    };
  }

  factory AttendanceModel.fromEntity(AttendanceEntity entity) {
    return AttendanceModel(
      id: entity.id,
      userId: entity.userId,
      checkInTime: entity.checkInTime,
      checkOutTime: entity.checkOutTime,
      workDuration: entity.workDuration,
      isLate: entity.isLate,
    );
  }
}
