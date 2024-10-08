import 'dart:async';

import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/presentation/home/presenter/home_page_ui_state.dart';

class HomePresenter extends BasePresenter<HomePageUiState> {
  final Obs<HomePageUiState> uiState = Obs(HomePageUiState.empty());
  HomePageUiState get currentUiState => uiState.value;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startClock();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void startClock() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateCurrentTime();
    });
  }

  void updateCurrentTime() {
    uiState.value = currentUiState.copyWith(nowTimeIsIt: DateTime.now());
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(message: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
