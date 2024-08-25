import 'package:employee_attendance/core/base/base_ui_state.dart';
import 'package:employee_attendance/domain/entities/office_settings.dart';

class HomePageUiState extends BaseUiState {
  const HomePageUiState({
    required super.isLoading,
    required super.userMessage,
    required this.nowTimeIsIt,
    required this.greetingMessage,
    required this.canCheckIn,
    required this.canCheckOut,
    this.checkInTime,
    this.checkOutTime,
    this.workDuration,
    required this.isCheckedIn,
    this.officeSettings,
  });

  factory HomePageUiState.empty() {
    return HomePageUiState(
      isLoading: false,
      userMessage: '',
      nowTimeIsIt: DateTime.now(),
      greetingMessage: '',
      canCheckIn: false,
      canCheckOut: false,
      checkInTime: null,
      checkOutTime: null,
      workDuration: null,
      isCheckedIn: false,
      officeSettings: null,
    );
  }

  final bool canCheckIn;
  final bool canCheckOut;
  final DateTime nowTimeIsIt;
  final String greetingMessage;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final Duration? workDuration;
  final bool isCheckedIn;
  final OfficeSettings? officeSettings;

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        nowTimeIsIt,
        greetingMessage,
        checkInTime,
        checkOutTime,
        workDuration,
        isCheckedIn,
        officeSettings,
        canCheckIn,
        canCheckOut,
      ];

  HomePageUiState copyWith({
    bool? isLoading,
    String? userMessage,
    DateTime? nowTimeIsIt,
    String? greetingMessage,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    Duration? workDuration,
    bool? isCheckedIn,
    OfficeSettings? officeSettings,
    bool? canCheckIn,
    bool? canCheckOut,
  }) {
    return HomePageUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      nowTimeIsIt: nowTimeIsIt ?? this.nowTimeIsIt,
      greetingMessage: greetingMessage ?? this.greetingMessage,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      workDuration: workDuration ?? this.workDuration,
      isCheckedIn: isCheckedIn ?? this.isCheckedIn,
      officeSettings: officeSettings ?? this.officeSettings,
      canCheckIn: canCheckIn ?? this.canCheckIn,
      canCheckOut: canCheckOut ?? this.canCheckOut,
    );
  }
}
