import 'package:employee_attendance/core/base/base_ui_state.dart';

class AdminDashboardUiState extends BaseUiState {
  const AdminDashboardUiState({
    required super.isLoading,
    required super.userMessage,
  });

  factory AdminDashboardUiState.empty() {
    return const AdminDashboardUiState(
      isLoading: false,
      userMessage: '',
    );
  }

  @override
  List<Object?> get props => [isLoading, userMessage];

  AdminDashboardUiState copyWith({
    bool? isLoading,
    String? userMessage,
  }) {
    return AdminDashboardUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
    );
  }
}
