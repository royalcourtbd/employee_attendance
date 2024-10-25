import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/domain/entities/employee_entity.dart';
import 'package:employee_attendance/domain/usecases/add_employee_use_case.dart';
import 'package:employee_attendance/domain/usecases/generate_new_employee_id_use_case.dart';
import 'package:employee_attendance/presentation/admin/employee/presenter/add_employee_ui_state.dart';
import 'package:flutter/material.dart';

class AddEmployeePresenter extends BasePresenter<AddEmployeeUiState> {
  final AddEmployeeUseCase _addEmployeeUseCase;
  final GenerateNewEmployeeIdUseCase _generateNewEmployeeIdUseCase;

  AddEmployeePresenter(
      this._addEmployeeUseCase, this._generateNewEmployeeIdUseCase);

  final Obs<AddEmployeeUiState> uiState = Obs(AddEmployeeUiState.empty());
  AddEmployeeUiState get currentUiState => uiState.value;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void updateRole(String role) {
    uiState.value = currentUiState.copyWith(selectedRole: role);
  }

  void updateJoiningDate(DateTime date) {
    uiState.value = currentUiState.copyWith(selectedJoiningDate: date);
  }

  Future<void> addEmployee() async {
    if (_validateInputs()) {
      await toggleLoading(loading: true);
      try {
        final newEmployeeId = await _generateNewEmployeeIdUseCase.execute();

        final newEmployee = EmployeeEntity(
          id: '', // This will be set by Firebase
          documentId: '', // This will be set by Firebase
          name: nameController.text,
          email: emailController.text,
          designation: designationController.text,
          joiningDate: currentUiState.selectedJoiningDate,
          phoneNumber: phoneController.text,
          role: currentUiState.selectedRole,
          employeeId: newEmployeeId,
          employeeStatus: true,
        );

        await _addEmployeeUseCase.execute(newEmployee);
        await addUserMessage('Employee added successfully');
        _clearInputs();
      } catch (e) {
        await addUserMessage('Failed to add employee: $e');
      } finally {
        await toggleLoading(loading: false);
      }
    }
  }

  bool _validateInputs() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        designationController.text.isEmpty ||
        phoneController.text.isEmpty) {
      addUserMessage('Please fill all fields');
      return false;
    }
    return true;
  }

  void _clearInputs() {
    nameController.clear();
    emailController.clear();
    designationController.clear();
    phoneController.clear();
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
    return showMessage(message: currentUiState.userMessage);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
