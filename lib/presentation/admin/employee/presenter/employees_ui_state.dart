// lib/presentation/admin/employee/presenter/employees_ui_state.dart ফাইলে

import 'package:employee_attendance/core/base/base_ui_state.dart';
import 'package:employee_attendance/domain/entities/employee.dart';

class EmployeesUiState extends BaseUiState {
  final List<Employee> employees;
  final List<Employee> filteredEmployees;

  const EmployeesUiState({
    required super.isLoading,
    required super.userMessage,
    required this.employees,
    required this.filteredEmployees,
  });

  factory EmployeesUiState.empty() {
    return const EmployeesUiState(
      isLoading: false,
      userMessage: '',
      employees: [],
      filteredEmployees: [],
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        employees,
        filteredEmployees,
      ];

  EmployeesUiState copyWith({
    bool? isLoading,
    String? userMessage,
    List<Employee>? employees,
    List<Employee>? filteredEmployees,
  }) {
    return EmployeesUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      employees: employees ?? this.employees,
      filteredEmployees: filteredEmployees ?? this.filteredEmployees,
    );
  }
}
