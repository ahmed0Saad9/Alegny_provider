import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/ForgetPassword/Bloc/repo/check_email_and_send_otp_repo.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/ForgetPassword/Bloc/repo/validate-otp-and-change-password_repo.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/ForgetPassword/Ui/Screens/new_password_screen.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/ForgetPassword/Ui/Screens/pin_code.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/LogIn/Ui/Screens/login_screen.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Verification/Ui/Screens/verification_forget_password_screen.dart';
import 'package:Alegny_provider/src/core/services/Base/base_controller.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';

class ForgetPasswordController
    extends BaseController<CheckEmailAndSendOtpRepo> {
  @override
  get repository => sl<CheckEmailAndSendOtpRepo>();

  late TextEditingController pinCodeController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController emailController;

  late StreamController<ErrorAnimationType> errorController;

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetPasswordGlobalKey = GlobalKey<FormState>();

  String _token = '';
  String _email = '';
  String _verifiedCode = ''; // Store verified code

  final ValidateOtpAndChangePasswordRepo _validateOtpAndChangePasswordRepo =
      sl<ValidateOtpAndChangePasswordRepo>();

  bool _isDisposed = false;

  // Initialize controllers
  @override
  void onInit() {
    super.onInit();
    _initTextEditing();
  }

  void _initTextEditing() {
    pinCodeController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    emailController = TextEditingController();
    errorController = StreamController<ErrorAnimationType>();
    _isDisposed = false;
  }

  // Safe method to check if controllers are still valid
  bool get areControllersValid {
    return !_isDisposed;
  }

  // Clear all text fields
  void clearAllFields() {
    if (areControllersValid) {
      pinCodeController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
      // Don't clear email controller as it might be needed for resend
    }
  }

  // Reset only OTP fields
  void resetOtpFields() {
    if (areControllersValid) {
      pinCodeController.clear();
    }
  }

  // Reset only password fields
  void resetPasswordFields() {
    if (areControllersValid) {
      newPasswordController.clear();
      confirmPasswordController.clear();
    }
  }

  // Send OTP for password reset
  Future<void> sendOtp({bool isResendCode = false}) async {
    if (!areControllersValid) {
      _initTextEditing(); // Reinitialize if disposed
    }

    if (globalKey.currentState!.validate()) {
      globalKey.currentState!.save();
      showEasyLoading();

      var result =
          await repository!.checkEmailAndSendOtp(email: emailController.text);
      closeEasyLoading();

      result.when(success: (Response response) {
        _token = response.data['token'] ?? '';
        _email = emailController.text;

        if (!isResendCode) {
          // Clear OTP field when navigating to new screen
          resetOtpFields();
          Get.to(() => VerificationForgetPasswordScreen(
                token: _token,
                email: _email,
              ));
        }
        successEasyLoading(response.data["message"] ?? "OTP sent successfully");
      }, failure: (NetworkExceptions error) {
        actionNetworkExceptions(error);
      });
    }
  }

  // Verify OTP code and navigate to password screen
  void checkCode() {
    if (!areControllersValid) {
      _initTextEditing(); // Reinitialize if disposed
    }

    if (pinCodeController.text.length == 6) {
      // Store the code for later verification
      _verifiedCode = pinCodeController.text;

      // Clear password fields when navigating to new screen
      resetPasswordFields();
      Get.to(() => NewPasswordScreen(
            token: _token,
            email: _email,
            code: _verifiedCode,
          ));
    } else {
      errorEasyLoading("Please enter complete OTP code");
      errorController.add(ErrorAnimationType.shake);
    }
  }

  // Reset password with OTP - This will verify the OTP at the backend
  Future<void> resetPassword({
    required String token,
    required String email,
    required String code,
  }) async {
    if (!areControllersValid) {
      _initTextEditing(); // Reinitialize if disposed
    }

    if (resetPasswordGlobalKey.currentState!.validate() &&
        newPasswordController.text == confirmPasswordController.text) {
      resetPasswordGlobalKey.currentState!.save();
      showEasyLoading();

      var result =
          await _validateOtpAndChangePasswordRepo.validateOtpAndChangePassword(
        email: email,
        code: code,
        newPassword: newPasswordController.text,
        confirmNewPassword: confirmPasswordController.text,
      );

      closeEasyLoading();

      result.when(success: (Response response) {
        // Clear all fields after successful password reset
        clearAllFields();
        _verifiedCode = '';
        Get.offAll(() => const LoginScreen());
        successEasyLoading(
            response.data["message"] ?? "Password reset successfully");
      }, failure: (NetworkExceptions error) {
        // Check if it's an invalid/expired OTP error
        actionNetworkExceptions(error);

        // If OTP is invalid, suggest going back to re-enter OTP
        // You can add a dialog here to ask user if they want to go back
        errorEasyLoading(
          "Invalid or expired reset code. Please verify your OTP and try again.",
        );
      });
    } else if (newPasswordController.text != confirmPasswordController.text) {
      errorEasyLoading("Passwords do not match");
    }
  }

  // Safe disposal method
  @override
  void onClose() {
    _disposeTextEditing();
    super.onClose();
  }

  void _disposeTextEditing() {
    if (!_isDisposed) {
      pinCodeController.dispose();
      newPasswordController.dispose();
      confirmPasswordController.dispose();
      emailController.dispose();
      errorController.close();
      _isDisposed = true;
    }
  }
}
