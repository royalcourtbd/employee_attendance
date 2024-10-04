import 'package:employee_attendance/core/base/base_ui_state.dart';
import 'package:employee_attendance/domain/entities/employee.dart';

class ProfilePageUiState extends BaseUiState {
  final Employee? employee;

  const ProfilePageUiState({
    required super.isLoading,
    required super.userMessage,
    this.employee,
  });

  factory ProfilePageUiState.empty() {
    return const ProfilePageUiState(
      isLoading: false,
      userMessage: '',
      employee: null,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        employee,
      ];

  ProfilePageUiState copyWith({
    bool? isLoading,
    String? userMessage,
    Employee? employee,
  }) {
    return ProfilePageUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      employee: employee ?? this.employee,
    );
  }
}
