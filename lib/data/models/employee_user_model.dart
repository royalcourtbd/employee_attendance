import 'package:employee_attendance/domain/entities/employee_entity.dart';

class EmployeeUserModel extends EmployeeEntity {
  const EmployeeUserModel({
    required super.id,
    super.name,
    super.role,
    super.joiningDate,
    super.image,
    super.employeeId,
    super.documentId,
    super.phoneNumber,
    super.deviceToken,
    super.employeeStatus,
    super.email,
    super.designation,
  });

  factory EmployeeUserModel.fromJson(Map<String, dynamic> json) {
    return EmployeeUserModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      role: json['role'] as String?,
      joiningDate: json['joiningDate'] != null
          ? DateTime.parse(json['joiningDate'] as String)
          : null,
      image: json['image'] as String?,
      employeeId: json['employeeId'] as String?,
      documentId: json['documentId'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      deviceToken: json['deviceToken'] as String?,
      employeeStatus: json['employeeStatus'] as bool? ?? false,
      email: json['email'] as String?,
      designation: json['designation'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'joiningDate': joiningDate?.toIso8601String(),
      'image': image,
      'employeeId': employeeId,
      'documentId': documentId,
      'phoneNumber': phoneNumber,
      'deviceToken': deviceToken,
      'employeeStatus': employeeStatus,
      'email': email,
      'designation': designation,
    };
  }

  factory EmployeeUserModel.fromEntity(EmployeeEntity entity) {
    return EmployeeUserModel(
      id: entity.id,
      name: entity.name,
      role: entity.role,
      joiningDate: entity.joiningDate,
      image: entity.image,
      employeeId: entity.employeeId,
      documentId: entity.documentId,
      phoneNumber: entity.phoneNumber,
      deviceToken: entity.deviceToken,
      employeeStatus: entity.employeeStatus,
      email: entity.email,
      designation: entity.designation,
    );
  }
  @override
  String toString() {
    return 'EmployeeUserModel(id: $id, name: $name, email: $email, role: $role)';
  }
}
