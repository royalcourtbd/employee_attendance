import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:employee_attendance/domain/usecases/get_all_employees_use_case.dart';
import 'package:employee_attendance/presentation/admin/employee/presenter/employees_ui_state.dart';
import 'package:employee_attendance/presentation/admin/employee/ui/add_employee_page.dart';
import 'package:flutter/material.dart';

class EmployeesPresenter extends BasePresenter<EmployeesUiState> {
  final GetAllEmployeesUseCase _allEmployeesUseCase;

  EmployeesPresenter(this._allEmployeesUseCase);

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

    _allEmployeesUseCase.execute().listen(
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

  void addEmployee({required BuildContext context}) {
    context.navigatorPush(AddEmployeePage());
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
