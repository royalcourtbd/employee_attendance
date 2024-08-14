class Attendance {
  final String id;
  final String userId;
  final DateTime checkInTime;
  final DateTime? checkOutTime;
  final bool isLate;

  Attendance({
    required this.id,
    required this.userId,
    required this.checkInTime,
    this.checkOutTime,
    required this.isLate,
  });
}
