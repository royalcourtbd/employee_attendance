// lib/domain/entities/user.dart

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? name;
  final DateTime? joiningDate;
  final String? image;
  final String? employeeId;
  final String? documentId;
  final String? phoneNumber;
  final String? deviceToken;
  final bool isEmployee;
  final String? email;
  final String? designation;

  const User({
    required this.id,
    this.name,
    this.joiningDate,
    this.image,
    this.employeeId,
    this.documentId,
    this.phoneNumber,
    this.deviceToken,
    required this.isEmployee,
    this.email,
    this.designation,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        joiningDate,
        image,
        employeeId,
        documentId,
        phoneNumber,
        deviceToken,
        isEmployee,
        email,
        designation,
      ];
}
