// lib/presentation/profile/presenter/profile_page_presenter.dart

import 'dart:io';

import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/services/firebase_service.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:employee_attendance/domain/usecases/change_password_use_case.dart';
import 'package:employee_attendance/domain/usecases/fetch_user_data_use_case.dart';
import 'package:employee_attendance/domain/usecases/get_user_stream_use_case.dart';
import 'package:employee_attendance/domain/usecases/logout_usecase.dart';
import 'package:employee_attendance/domain/usecases/update_user_use_case.dart';
import 'package:employee_attendance/presentation/home/presenter/home_presenter.dart';
import 'package:employee_attendance/presentation/profile/presenter/profile_page_ui_state.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePagePresenter extends BasePresenter<ProfilePageUiState> {
  final LogoutUseCase _logoutUseCase;
  final UpdateUserUseCase _updateUserUseCase;
  final FetchUserDataUseCase _fetchUserDataUseCase;
  final GetUserStreamUseCase _getUserStreamUseCase;
  final FirebaseService _firebaseService;
  final ChangePasswordUseCase _changePasswordUseCase;

  ProfilePagePresenter(
    this._firebaseService,
    this._logoutUseCase,
    this._fetchUserDataUseCase,
    this._getUserStreamUseCase,
    this._updateUserUseCase,
    this._changePasswordUseCase,
  );

  final Obs<ProfilePageUiState> uiState = Obs(ProfilePageUiState.empty());
  ProfilePageUiState get currentUiState => uiState.value;
  late final HomePresenter _homePresenter = locate<HomePresenter>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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

  Future<void> updateProfileImage({required String userId}) async {
    try {
      final XFile? image = await _firebaseService.imagePicker
          .pickImage(source: ImageSource.gallery);
      if (image == null) {
        await addUserMessage('No image selected');
        return;
      }
      // final String userId = currentUiState.employee?.id ?? '';

      if (userId.isEmpty) {
        await addUserMessage('User ID not found');
        return;
      }
      uiState.value = currentUiState.copyWith(isUpdatingImage: true);
      final File imageFile = File(image.path);
      final String fileName = 'profile_images/$userId.jpg';
      final Reference storageRef =
          _firebaseService.storage.ref().child(fileName);

      // Use putData instead of putFile
      final Uint8List imageData = await imageFile.readAsBytes();
      final UploadTask uploadTask = storageRef.putData(imageData);

      // Listen to upload progress
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress = snapshot.bytesTransferred / snapshot.totalBytes;
        uiState.value = currentUiState.copyWith(uploadProgress: progress);
      });

      final TaskSnapshot taskSnapshot = await uploadTask;
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      final updatedEmployee =
          currentUiState.employee?.copyWith(image: downloadUrl);
      if (updatedEmployee != null) {
        await updateUser(updatedEmployee);
        await addUserMessage('Successfully updated profile image');
      }
    } catch (e) {
      await addUserMessage('Error uploading image: $e');
    } finally {
      uiState.value = currentUiState.copyWith(
        isUpdatingImage: false,
        uploadProgress: 0,
      );
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

  Future<void> changePassword(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (_validateInputs()) {
        await toggleLoading(loading: true);
        try {
          await _changePasswordUseCase.execute(newPasswordController.text);
          await addUserMessage('Password changed successfully');
          _clearInputs();
          await toggleLoading(loading: false);
          context.navigatorPop();
        } catch (e) {
          await addUserMessage('Failed to change password: $e');
        }
      }
    }
  }

  bool _validateInputs() {
    if (newPasswordController.text != confirmPasswordController.text) {
      addUserMessage('New password and confirm password do not match');
      return false;
    }
    return true;
  }

  void _clearInputs() {
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
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
