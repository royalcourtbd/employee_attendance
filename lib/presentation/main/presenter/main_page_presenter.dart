import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/presentation/main/presenter/main_page_ui_state.dart';

class MainPagePresenter extends BasePresenter<MainPageUiState> {
  final Obs<MainPageUiState> uiState = Obs(MainPageUiState.empty());
  MainPageUiState get currentUiState => uiState.value;

  void updateIndex({required int index}) {
    uiState.value = uiState.value.copyWith(currentNavIndex: index);
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
