import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/presentation/history/presenter/history_page_ui_state.dart';

class HistoryPagePresenter extends BasePresenter<HistoryPageUiState> {
  final Obs<HistoryPageUiState> uiState = Obs(HistoryPageUiState.empty());
  HistoryPageUiState get currentUiState => uiState.value;

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
