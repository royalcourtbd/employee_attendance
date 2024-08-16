import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/presentation/login/presenter/login_page_ui_state.dart';

class LoginPagePresenter extends BasePresenter<LoginPageUiState> {
  final Obs<LoginPageUiState> uiState = Obs(LoginPageUiState.empty());
  LoginPageUiState get currentUiState => uiState.value;

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
