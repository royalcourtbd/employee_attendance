import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:employee_attendance/domain/usecases/employee_usecases.dart';
import 'package:employee_attendance/presentation/admin/employee/presenter/employees_ui_state.dart';
import 'package:flutter/material.dart';

class EmployeesPresenter extends BasePresenter<EmployeesUiState> {
  final EmployeeUseCases _userUseCases;

  EmployeesPresenter(this._userUseCases);

  final Obs<EmployeesUiState> uiState = Obs(EmployeesUiState.empty());
  EmployeesUiState get currentUiState => uiState.value;

  final TextEditingController searchTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadEmployees();
  }

  Future<void> loadEmployees() async {
    await toggleLoading(loading: true);

    _userUseCases.getAllEmployees().listen(
      (List<Employee> employees) {
        uiState.value = currentUiState.copyWith(
          employees: employees,
          filteredEmployees: employees,
        );
      },
      onError: (error) {
        addUserMessage('Failed to load employee information. $error');
      },
      onDone: () {
        toggleLoading(loading: false);
      },
    );
  }

  // lib/presentation/admin/employee/presenter/employees_presenter.dart ফাইলে

  void searchEmployees(String query) {
    if (query.isEmpty) {
      uiState.value = currentUiState.copyWith(
        filteredEmployees: currentUiState.employees,
      );
    } else {
      final List<Employee> filteredList =
          currentUiState.employees.where((employee) {
        return employee.name?.toLowerCase().contains(query.toLowerCase()) ==
                true ||
            employee.employeeId?.toLowerCase().contains(query.toLowerCase()) ==
                true;
      }).toList();
      uiState.value = currentUiState.copyWith(
        filteredEmployees: filteredList,
      );
    }
  }

  void editEmployee(Employee employee) {
    // Implement edit employee logic
  }

  void addEmployee() {
    // Implement add employee logic
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
