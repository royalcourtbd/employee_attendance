import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:flutter/material.dart';

class EmployeeListItem extends StatelessWidget {
  final Employee employee;
  final VoidCallback onEdit;

  const EmployeeListItem({
    super.key,
    required this.employee,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage:
            employee.image != null ? NetworkImage(employee.image!) : null,
        child: employee.image == null ? Text(employee.name?[0] ?? '') : null,
      ),
      title: Text(employee.name ?? ''),
      subtitle: Text(employee.employeeId ?? ''),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: onEdit,
      ),
    );
  }
}
