import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/presentable_widget_builder.dart';
import 'package:employee_attendance/presentation/admin/employee/presenter/employees_presenter.dart';
import 'package:employee_attendance/presentation/admin/employee/widgets/employee_list_item.dart';

import 'package:flutter/material.dart';

class EmployeesPage extends StatelessWidget {
  EmployeesPage({super.key});

  final EmployeesPresenter _employeesPresenter = locate<EmployeesPresenter>();

  @override
  Widget build(BuildContext context) {
    return PresentableWidgetBuilder(
      presenter: _employeesPresenter,
      builder: () {
        final uiState = _employeesPresenter.currentUiState;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Employees'),
          ),
          body: ListView.builder(
            itemCount: uiState.employees.length,
            itemBuilder: (context, index) {
              final employee = uiState.employees[index];

              return EmployeeListItem(
                employee: employee,
                onEdit: () => _employeesPresenter.editEmployee(employee),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _employeesPresenter.addEmployee,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
