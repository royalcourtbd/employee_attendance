import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/repositories/firebase_auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = FirebaseAuthRepository();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    try {
      await _authRepository.signIn(
        emailController.text.trim(),
        passwordController.text,
      );
    } catch (e) {
      Get.snackbar('Error', _getErrorMessage(e.toString()),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'invalid-email':
        return 'The email address is badly formatted.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}
