import 'package:employee_attendance/core/base/base_ui_state.dart';

class HomePageUiState extends BaseUiState {
  const HomePageUiState({
    required super.isLoading,
    required super.userMessage,
    required this.nowTimeIsIt,
  });

  factory HomePageUiState.empty() {
    return HomePageUiState(
      isLoading: false,
      userMessage: '',
      nowTimeIsIt: DateTime.now(),
    );
  }

  final DateTime nowTimeIsIt;

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        nowTimeIsIt,
      ];

  HomePageUiState copyWith({
    bool? isLoading,
    String? message,
    String? status,
    bool? canCheckIn,
    bool? canCheckOut,
    DateTime? nowTimeIsIt,
  }) {
    return HomePageUiState(
      isLoading: isLoading ?? super.isLoading,
      userMessage: message ?? super.userMessage,
      nowTimeIsIt: nowTimeIsIt ?? this.nowTimeIsIt,
    );
  }
}
