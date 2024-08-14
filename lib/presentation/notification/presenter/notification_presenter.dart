import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/presentation/notification/presenter/notification_ui_state.dart';

class NotificationPresenter extends BasePresenter<NotificationUiState> {
  final Obs<NotificationUiState> uiState = Obs(NotificationUiState.empty());
  NotificationUiState get currentUiState => uiState.value;

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
