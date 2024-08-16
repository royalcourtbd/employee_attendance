import 'package:employee_attendance/core/base/base_ui_state.dart';

class HistoryPageUiState extends BaseUiState {
  const HistoryPageUiState({
    required super.isLoading,
    required super.userMessage,
  });

  factory HistoryPageUiState.empty() {
    return const HistoryPageUiState(
      isLoading: false,
      userMessage: '',
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
      ];

  HistoryPageUiState copyWith({
    bool? isLoading,
    String? userMessage,
  }) {
    return HistoryPageUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
    );
  }
}
