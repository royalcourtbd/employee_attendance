import 'package:employee_attendance/core/base/base_ui_state.dart';

class AddEmployeeUiState extends BaseUiState {
  final String selectedRole;

  const AddEmployeeUiState({
    required super.isLoading,
    required super.userMessage,
    required this.selectedRole,
  });

  factory AddEmployeeUiState.empty() {
    return const AddEmployeeUiState(
      isLoading: false,
      userMessage: '',
      selectedRole: 'employee',
    );
  }

  @override
  List<Object?> get props => [isLoading, userMessage, selectedRole];

  AddEmployeeUiState copyWith({
    bool? isLoading,
    String? userMessage,
    String? selectedRole,
  }) {
    return AddEmployeeUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      selectedRole: selectedRole ?? this.selectedRole,
    );
  }
}
