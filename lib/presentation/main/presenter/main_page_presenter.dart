import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/presentation/employee_attendance.dart';
import 'package:employee_attendance/presentation/main/presenter/main_page_ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPagePresenter extends BasePresenter<MainPageUiState> {
  final Obs<MainPageUiState> uiState = Obs(MainPageUiState.empty());
  MainPageUiState get currentUiState => uiState.value;

  @override
  void onInit() {
    _setSystemUIOverlayStyle(EmployeeAttendance.globalContext);
    super.onInit();
  }

  void updateIndex({required int index}) {
    uiState.value = uiState.value.copyWith(currentNavIndex: index);
  }

  void _setSystemUIOverlayStyle(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
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
