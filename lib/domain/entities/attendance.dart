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

  bool get isCheckedIn => checkOutTime == null;
}
