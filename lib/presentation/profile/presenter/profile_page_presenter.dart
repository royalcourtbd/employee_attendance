// lib/presentation/profile/presenter/profile_page_presenter.dart

import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/services/firebase_service.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/domain/entities/user.dart';
import 'package:employee_attendance/domain/usecases/user_usecases.dart';
import 'package:employee_attendance/presentation/home/presenter/home_presenter.dart';
import 'package:employee_attendance/presentation/profile/presenter/profile_page_ui_state.dart';
import 'package:flutter/material.dart';

class ProfilePagePresenter extends BasePresenter<ProfilePageUiState> {
  final UserUseCases _userUseCases;
  final FirebaseService _firebaseService;

  ProfilePagePresenter(this._userUseCases, this._firebaseService);

  late final HomePresenter _homePresenter = locate<HomePresenter>();

  final Obs<ProfilePageUiState> uiState = Obs(ProfilePageUiState.empty());
  ProfilePageUiState get currentUiState => uiState.value;

  @override
  void onInit() {
    super.onInit();
    _initUser();
  }

  void _initUser() {
    final currentUser = _firebaseService.auth.currentUser;
    if (currentUser != null) {
      initUserStream(currentUser.uid);
    } else {
      addUserMessage('No user logged in');
    }
  }

  void initUserStream(String userId) {
    debugPrint('User ID: $userId');
    _userUseCases.getUserStream(userId).listen(
      (user) {
        if (user != null) {
          uiState.value = currentUiState.copyWith(user: user);
        } else {
          addUserMessage('User data not found');
        }
      },
      onError: (error) {
        debugPrint('Error fetching user data: $error');
        addUserMessage('Error fetching user data');
      },
    );
  }

  Future<void> fetchUserData(String userId) async {
    await toggleLoading(loading: true);
    try {
      final user = await _userUseCases.fetchUserData(userId);
      if (user != null) {
        uiState.value = currentUiState.copyWith(user: user);
      } else {
        await addUserMessage('Failed to fetch user data');
      }
    } catch (e) {
      debugPrint('Error fetching user data: $e');
      await addUserMessage('Error fetching user data');
    } finally {
      await toggleLoading(loading: false);
    }
  }

  Future<void> updateUser(User updatedUser) async {
    await toggleLoading(loading: true);
    try {
      await _userUseCases.updateUser(updatedUser);
      uiState.value = currentUiState.copyWith(user: updatedUser);
      await addUserMessage('User updated successfully');
    } catch (e) {
      debugPrint('Error updating user: $e');
      await addUserMessage('Error updating user');
    } finally {
      await toggleLoading(loading: false);
    }
  }

  Future<void> logout() async {
    await toggleLoading(loading: true);
    try {
      _homePresenter.resetAttendance();
      await _userUseCases.logout();
      uiState.value = ProfilePageUiState.empty();

      showMessage(message: 'Logged out successfully');
    } catch (e) {
      debugPrint('Error logging out: $e');
      await addUserMessage('Error logging out');
    } finally {
      await toggleLoading(loading: false);
    }
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
