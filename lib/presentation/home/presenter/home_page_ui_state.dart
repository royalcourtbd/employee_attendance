import 'package:employee_attendance/core/base/base_ui_state.dart';

class HomePageUiState extends BaseUiState {
  const HomePageUiState({
    required super.isLoading,
    required super.userMessage,
    required this.status,
    required this.canCheckIn,
    required this.canCheckOut,
  });

  factory HomePageUiState.empty() {
    return const HomePageUiState(
      isLoading: false,
      userMessage: '',
      status: '',
      canCheckIn: false,
      canCheckOut: false,
    );
  }

  final String status;
  final bool canCheckIn;
  final bool canCheckOut;

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        status,
        canCheckIn,
        canCheckOut,
      ];

  HomePageUiState copyWith({
    bool? isLoading,
    String? message,
    String? status,
    bool? canCheckIn,
    bool? canCheckOut,
  }) {
    return HomePageUiState(
      isLoading: isLoading ?? super.isLoading,
      userMessage: message ?? super.userMessage,
      status: status ?? this.status,
      canCheckIn: canCheckIn ?? this.canCheckIn,
      canCheckOut: canCheckOut ?? this.canCheckOut,
    );
  }
}
