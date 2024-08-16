import 'package:employee_attendance/core/base/base_ui_state.dart';

class MainPageUiState extends BaseUiState {
  const MainPageUiState({
    required super.isLoading,
    required super.userMessage,
    required this.currentNavIndex,
  });

  factory MainPageUiState.empty() {
    return const MainPageUiState(
      isLoading: false,
      userMessage: '',
      currentNavIndex: 1,
    );
  }

  final int currentNavIndex;

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        currentNavIndex,
      ];

  MainPageUiState copyWith({
    bool? isLoading,
    String? userMessage,
    int? currentNavIndex,
  }) {
    return MainPageUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      currentNavIndex: currentNavIndex ?? this.currentNavIndex,
    );
  }
}
