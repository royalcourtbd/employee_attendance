import 'package:employee_attendance/core/base/base_ui_state.dart';
import 'package:flutter/material.dart';

class SettingsUiState extends BaseUiState {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final int lateThreshold;
  final List<String> workDays;
  final String ssid; // Add this new property
  final double latitude;
  final double longitude;

  const SettingsUiState({
    required super.isLoading,
    required super.userMessage,
    required this.startTime,
    required this.endTime,
    required this.lateThreshold,
    required this.workDays,
    required this.ssid, // Add this
    required this.latitude,
    required this.longitude,
  });

  factory SettingsUiState.empty() {
    return const SettingsUiState(
      isLoading: false,
      userMessage: '',
      startTime: TimeOfDay(hour: 9, minute: 0),
      endTime: TimeOfDay(hour: 17, minute: 0),
      lateThreshold: 10,
      workDays: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
      ssid: '', // Add this with a default empty string
      latitude: 0.0,
      longitude: 0.0,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        startTime,
        endTime,
        lateThreshold,
        workDays,
        ssid, // Add this
        latitude,
        longitude,
      ];

  SettingsUiState copyWith({
    bool? isLoading,
    String? userMessage,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    int? lateThreshold,
    List<String>? workDays,
    String? ssid, // Add this
    double? latitude,
    double? longitude,
  }) {
    return SettingsUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      lateThreshold: lateThreshold ?? this.lateThreshold,
      workDays: workDays ?? this.workDays,
      ssid: ssid ?? this.ssid, // Add this
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
