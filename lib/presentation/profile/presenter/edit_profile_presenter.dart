import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/presentation/profile/presenter/edit_profile_ui_state.dart';

import 'package:flutter/material.dart';

class EditProfilePresenter extends BasePresenter<EditProfileUiState> {
  final Obs<EditProfileUiState> uiState = Obs(EditProfileUiState.empty());
  EditProfileUiState get currentUiState => uiState.value;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
