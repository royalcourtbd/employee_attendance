import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/presentation/profile/presenter/profile_page_ui_state.dart';

class ProfilePagePresenter extends BasePresenter<ProfilePageUiState> {
  final Obs<ProfilePageUiState> uiState = Obs(ProfilePageUiState.empty());
  ProfilePageUiState get currentUiState => uiState.value;

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
