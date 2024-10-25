import 'package:employee_attendance/core/base/base_ui_state.dart';
import 'package:employee_attendance/domain/entities/employee_entity.dart';

class ProfilePageUiState extends BaseUiState {
  final EmployeeEntity? employee;
  final bool isUpdatingImage;
  final double uploadProgress;

  const ProfilePageUiState({
    required super.isLoading,
    required super.userMessage,
    this.employee,
    required this.isUpdatingImage,
    required this.uploadProgress,
  });

  factory ProfilePageUiState.empty() {
    return const ProfilePageUiState(
      isLoading: false,
      userMessage: '',
      employee: null,
      isUpdatingImage: false,
      uploadProgress: 0,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        employee,
        isUpdatingImage,
        uploadProgress,
      ];

  ProfilePageUiState copyWith({
    bool? isLoading,
    String? userMessage,
    EmployeeEntity? employee,
    bool? isUpdatingImage,
    double? uploadProgress,
  }) {
    return ProfilePageUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      employee: employee ?? this.employee,
      isUpdatingImage: isUpdatingImage ?? this.isUpdatingImage,
      uploadProgress: uploadProgress ?? this.uploadProgress,
    );
  }
}
