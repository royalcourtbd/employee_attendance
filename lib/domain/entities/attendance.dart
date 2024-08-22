class Attendance {
  final String id;
  final String userId;
  final DateTime checkInTime;
  final DateTime? checkOutTime;
  final Duration? workDuration;
  final bool isLate;

  const Attendance({
    required this.id,
    required this.userId,
    required this.checkInTime,
    this.checkOutTime,
    this.workDuration,
    required this.isLate,
  });

  Attendance copyWith({
    String? id,
    String? userId,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    Duration? workDuration,
    bool? isLate,
  }) {
    return Attendance(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      workDuration: workDuration ?? this.workDuration,
      isLate: isLate ?? this.isLate,
    );
  }
}
