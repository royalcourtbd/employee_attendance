import 'package:employee_attendance/core/base/base_ui_state.dart';

class AddEmployeeUiState extends BaseUiState {
  final String selectedRole;
  final DateTime selectedJoiningDate;

  const AddEmployeeUiState({
    required super.isLoading,
    required super.userMessage,
    required this.selectedRole,
    required this.selectedJoiningDate,
  });

  factory AddEmployeeUiState.empty() {
    return AddEmployeeUiState(
      isLoading: false,
      userMessage: '',
      selectedRole: 'employee',
      selectedJoiningDate: DateTime.now(),
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, userMessage, selectedRole, selectedJoiningDate];

  AddEmployeeUiState copyWith({
    bool? isLoading,
    String? userMessage,
    String? selectedRole,
    DateTime? selectedJoiningDate,
  }) {
    return AddEmployeeUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      selectedRole: selectedRole ?? this.selectedRole,
      selectedJoiningDate: selectedJoiningDate ?? this.selectedJoiningDate,
    );
  }
}
