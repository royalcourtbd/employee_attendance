import 'package:employee_attendance/core/base/base_ui_state.dart';
import 'package:employee_attendance/domain/entities/employee.dart';

class EmployeesUiState extends BaseUiState {
  final List<Employee> employees;

  const EmployeesUiState({
    required super.isLoading,
    required super.userMessage,
    required this.employees,
  });

  factory EmployeesUiState.empty() {
    return const EmployeesUiState(
      isLoading: false,
      userMessage: '',
      employees: [],
    );
  }

  @override
  List<Object?> get props => [isLoading, userMessage, employees];

  EmployeesUiState copyWith({
    bool? isLoading,
    String? userMessage,
    List<Employee>? employees,
  }) {
    return EmployeesUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      employees: employees ?? this.employees,
    );
  }
}
