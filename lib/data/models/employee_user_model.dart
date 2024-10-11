import 'package:employee_attendance/domain/entities/employee.dart';

class EmployeeUserModel extends Employee {
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

  // এই মেথডটি `User` অবজেক্ট থেকে `UserModel` অবজেক্ট তৈরি করতে সহায়ক হবে।
  factory EmployeeUserModel.fromUser(Employee user) {
    return EmployeeUserModel(
      id: user.id,
      name: user.name,
      role: user.role,
      joiningDate: user.joiningDate,
      image: user.image,
      employeeId: user.employeeId,
      documentId: user.documentId,
      phoneNumber: user.phoneNumber,
      deviceToken: user.deviceToken,
      employeeStatus: user.employeeStatus,
      email: user.email,
      designation: user.designation,
    );
  }
  @override
  String toString() {
    return 'EmployeeUserModel(id: $id, name: $name, email: $email, role: $role)';
  }
}
