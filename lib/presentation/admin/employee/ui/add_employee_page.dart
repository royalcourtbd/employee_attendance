import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/presentable_widget_builder.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/presentation/admin/employee/presenter/add_employee_presenter.dart';
import 'package:employee_attendance/presentation/common/date_picker_widget.dart';
import 'package:employee_attendance/presentation/common/loading_button_widget.dart';
import 'package:employee_attendance/presentation/login/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class AddEmployeePage extends StatelessWidget {
  AddEmployeePage({super.key});

  final AddEmployeePresenter _addEmployeePresenter =
      locate<AddEmployeePresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: _addEmployeePresenter,
      builder: () {
        final uiState = _addEmployeePresenter.currentUiState;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add Employee'),
          ),
          body: SingleChildScrollView(
            padding: padding20,
            child: Column(
              children: [
                CustomTextField(
                  textEditingController: _addEmployeePresenter.nameController,
                  theme: theme,
                  hintText: 'Employee Name',
                ),
                gapH20,
                CustomTextField(
                  textEditingController: _addEmployeePresenter.emailController,
                  theme: theme,
                  hintText: 'Employee Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                gapH20,
                CustomTextField(
                  textEditingController:
                      _addEmployeePresenter.designationController,
                  theme: theme,
                  hintText: 'Designation',
                ),
                gapH20,
                CustomTextField(
                  textEditingController: _addEmployeePresenter.phoneController,
                  theme: theme,
                  hintText: 'Phone Number',
                  keyboardType: TextInputType.phone,
                ),
                gapH20,
                DatePickerWidget(
                  selectedDate: uiState.selectedJoiningDate,
                  onDateSelected: _addEmployeePresenter.updateJoiningDate,
                  labelText: 'Joining Date',
                ),
                gapH20,
                Text(
                  'Role:',
                  style: theme.textTheme.titleMedium,
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Employee'),
                        value: 'employee',
                        groupValue: uiState.selectedRole,
                        onChanged: (value) =>
                            _addEmployeePresenter.updateRole(value!),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Admin'),
                        value: 'admin',
                        groupValue: uiState.selectedRole,
                        onChanged: (value) =>
                            _addEmployeePresenter.updateRole(value!),
                      ),
                    ),
                  ],
                ),
                gapH30,
                LoadingButtonWidget(
                  isLoading: _addEmployeePresenter.currentUiState.isLoading,
                  theme: theme,
                  buttonText: 'Add Employee',
                  onPressed: () => _addEmployeePresenter.addEmployee(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
