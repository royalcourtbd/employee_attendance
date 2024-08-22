import 'package:employee_attendance/core/base/base_ui_state.dart';

class HomePageUiState extends BaseUiState {
  const HomePageUiState({
    required super.isLoading,
    required super.userMessage,
    required this.nowTimeIsIt,
    required this.greetingMessage, // New property for greeting message
  });

  factory HomePageUiState.empty() {
    return HomePageUiState(
      isLoading: false,
      userMessage: '',
      nowTimeIsIt: DateTime.now(),
      greetingMessage: '', // Initialize with an empty greeting message
    );
  }

  final DateTime nowTimeIsIt;
  final String greetingMessage; // New property for greeting message

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        nowTimeIsIt,
        greetingMessage, // Add greetingMessage to props
      ];

  HomePageUiState copyWith({
    bool? isLoading,
    String? message,
    DateTime? nowTimeIsIt,
    String? greetingMessage, // Add greetingMessage to copyWith method
  }) {
    return HomePageUiState(
      isLoading: isLoading ?? super.isLoading,
      userMessage: message ?? super.userMessage,
      nowTimeIsIt: nowTimeIsIt ?? this.nowTimeIsIt,
      greetingMessage:
          greetingMessage ?? this.greetingMessage, // Update greetingMessage
    );
  }
}
