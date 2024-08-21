import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/services/firebase_service.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/domain/entities/user.dart';
import 'package:employee_attendance/domain/usecases/user_usecases.dart';
import 'package:employee_attendance/presentation/profile/presenter/profile_page_ui_state.dart';
import 'package:flutter/material.dart';

class ProfilePagePresenter extends BasePresenter<ProfilePageUiState> {
  final UserUseCases _userUseCases;
  final FirebaseService _firebaseService;
  ProfilePagePresenter(this._userUseCases, this._firebaseService);
  final Obs<ProfilePageUiState> uiState = Obs(ProfilePageUiState.empty());
  ProfilePageUiState get currentUiState => uiState.value;

  @override
  void onInit() {
    initUserStream(_firebaseService.auth.currentUser!.uid);
    super.onInit();
  }

  void initUserStream(String userId) {
    debugPrint('User ID: $userId');
    _userUseCases.getUserStream(userId).listen((user) {
      if (user != null) {
        uiState.value = currentUiState.copyWith(user: user);
      }
    });
  }

  Future<void> fetchUserData(String userId) async {
    await toggleLoading(loading: true);
    final user = await _userUseCases.fetchUserData(userId);
    if (user != null) {
      uiState.value = currentUiState.copyWith(user: user);
    } else {
      await addUserMessage('Failed to fetch user data');
    }
    await toggleLoading(loading: false);
  }

  Future<void> updateUser(User updatedUser) async {
    await toggleLoading(loading: true);
    await _userUseCases.updateUser(updatedUser);
    await toggleLoading(loading: false);
  }

  Future<void> logout() async {
    await _userUseCases.logout();
    showMessage(message: 'Logged out successfully');
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
