import 'package:employee_attendance/core/base/base_ui_state.dart';

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
    this.officeStartTime,
    this.officeEndTime,
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
      officeStartTime: null,
      officeEndTime: null,
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
  final DateTime? officeStartTime;
  final DateTime? officeEndTime;

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
        officeStartTime,
        officeEndTime,
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
    DateTime? officeStartTime,
    DateTime? officeEndTime,
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
      officeStartTime: officeStartTime ?? this.officeStartTime,
      officeEndTime: officeEndTime ?? this.officeEndTime,
      canCheckIn: canCheckIn ?? this.canCheckIn,
      canCheckOut: canCheckOut ?? this.canCheckOut,
    );
  }
}
