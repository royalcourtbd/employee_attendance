import 'package:employee_attendance/core/base/base_entity.dart';

class EmployeeEntity extends BaseEntity {
  final String id;
  final String? name;
  final String? role;
  final DateTime? joiningDate;
  final String? image;
  final String? employeeId;
  final String? documentId;
  final String? phoneNumber;
  final String? deviceToken;
  final bool employeeStatus;
  final String? email;
  final String? designation;

  const EmployeeEntity({
    required this.id,
    this.name,
    this.role,
    this.joiningDate,
    this.image,
    this.employeeId,
    this.documentId,
    this.phoneNumber,
    this.deviceToken,
    this.employeeStatus = false,
    this.email,
    this.designation,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        role,
        joiningDate,
        image,
        employeeId,
        documentId,
        phoneNumber,
        deviceToken,
        employeeStatus,
        email,
        designation,
      ];

  EmployeeEntity copyWith({
    String? id,
    String? name,
    String? role,
    DateTime? joiningDate,
    String? image,
    String? employeeId,
    String? documentId,
    String? phoneNumber,
    String? deviceToken,
    bool? employeeStatus,
    String? email,
    String? designation,
  }) {
    return EmployeeEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      joiningDate: joiningDate ?? this.joiningDate,
      image: image ?? this.image,
      employeeId: employeeId ?? this.employeeId,
      documentId: documentId ?? this.documentId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      deviceToken: deviceToken ?? this.deviceToken,
      employeeStatus: employeeStatus ?? this.employeeStatus,
      email: email ?? this.email,
      designation: designation ?? this.designation,
    );
  }
}
