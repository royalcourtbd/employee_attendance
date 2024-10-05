// lib/presentation/profile/presenter/profile_page_presenter.dart

import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/services/firebase_service.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:employee_attendance/domain/usecases/fetch_user_data_use_case.dart';
import 'package:employee_attendance/domain/usecases/get_user_stream_use_case.dart';
import 'package:employee_attendance/domain/usecases/logout_usecase.dart';
import 'package:employee_attendance/domain/usecases/update_user_use_case.dart';
import 'package:employee_attendance/presentation/home/presenter/home_presenter.dart';
import 'package:employee_attendance/presentation/profile/presenter/profile_page_ui_state.dart';
import 'package:flutter/material.dart';

class ProfilePagePresenter extends BasePresenter<ProfilePageUiState> {
  final LogoutUseCase _logoutUseCase;
  final UpdateUserUseCase _updateUserUseCase;
  final FetchUserDataUseCase _fetchUserDataUseCase;
  final GetUserStreamUseCase _getUserStreamUseCase;
  final FirebaseService _firebaseService;

  ProfilePagePresenter(
    this._firebaseService,
    this._logoutUseCase,
    this._fetchUserDataUseCase,
    this._getUserStreamUseCase,
    this._updateUserUseCase,
  );

  final Obs<ProfilePageUiState> uiState = Obs(ProfilePageUiState.empty());
  ProfilePageUiState get currentUiState => uiState.value;
  late final HomePresenter _homePresenter = locate<HomePresenter>();

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
    _getUserStreamUseCase.execute(userId).listen(
      (user) {
        if (user != null) {
          uiState.value = currentUiState.copyWith(employee: user);
        } else {
          addUserMessage('User data not found');
        }
      },
      onError: (error) {
        addUserMessage('Error fetching user data');
      },
    );
  }

  Future<void> fetchUserData(String userId) async {
    await toggleLoading(loading: true);
    try {
      final user = await _fetchUserDataUseCase.execute(userId);
      if (user != null) {
        uiState.value = currentUiState.copyWith(employee: user);
      } else {
        await addUserMessage('Failed to fetch user data');
      }
    } catch (e) {
      await addUserMessage('Error fetching user data');
    } finally {
      await toggleLoading(loading: false);
    }
  }

  Future<void> updateUser(Employee updatedUser) async {
    await toggleLoading(loading: true);
    try {
      await _updateUserUseCase.execute(updatedUser);
      uiState.value = currentUiState.copyWith(employee: updatedUser);
      await addUserMessage('User updated successfully');
    } catch (e) {
      await addUserMessage('Error updating employee');
    } finally {
      await toggleLoading(loading: false);
    }
  }

  Future<void> logout() async {
    await toggleLoading(loading: true);
    try {
      _homePresenter.resetAttendance();
      await _logoutUseCase.execute();
      uiState.value = ProfilePageUiState.empty();
      showMessage(message: 'Logged out successfully');
    } catch (e) {
      await addUserMessage('Error logging out');
    } finally {
      await toggleLoading(loading: false);
    }
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
    return showMessage(message: currentUiState.userMessage);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
