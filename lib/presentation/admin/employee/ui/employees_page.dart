import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/presentable_widget_builder.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/presentation/admin/employee/presenter/employees_presenter.dart';
import 'package:employee_attendance/presentation/admin/employee/widgets/employee_list_item.dart';
import 'package:employee_attendance/presentation/login/widgets/custom_text_field.dart';

import 'package:flutter/material.dart';

class EmployeesPage extends StatelessWidget {
  EmployeesPage({super.key});

  final EmployeesPresenter _employeesPresenter = locate<EmployeesPresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: _employeesPresenter,
      builder: () {
        final uiState = _employeesPresenter.currentUiState;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Employees'),
          ),
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              Padding(
                padding: padding10,
                child: CustomTextField(
                  textEditingController:
                      _employeesPresenter.searchTextController,
                  theme: theme,
                  icon: Icons.search,
                  hintText: 'Find Employee by Name or ID',
                  onChanged: (value) =>
                      _employeesPresenter.searchEmployees(value),
                ),
              ),
              ListView.builder(
                itemCount: uiState.filteredEmployees.length,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final employee = uiState.filteredEmployees[index];

                  return EmployeeListItem(
                    employee: employee,
                    onEdit: () => _employeesPresenter.editEmployee(employee),
                    theme: theme,
                  );
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _employeesPresenter.addEmployee(context: context),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
