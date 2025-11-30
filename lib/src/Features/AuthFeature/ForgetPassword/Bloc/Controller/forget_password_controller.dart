import 'dart:async';

import 'package:Alegny_provider/src/Features/AuthFeature/ForgetPassword/Bloc/repo/verify_otp_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/ForgetPassword/Bloc/repo/check_email_and_send_otp_repo.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/ForgetPassword/Bloc/repo/change_password_repo.dart';
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
  final VerifyOtpRepo _verifyOtpRepo = sl<VerifyOtpRepo>();

  final ChangePasswordRepo _changePasswordRepo = sl<ChangePasswordRepo>();
  String _resetToken = '';
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
  Future<void> checkCode() async {
    if (!areControllersValid) {
      _initTextEditing();
    }

    if (pinCodeController.text.length == 6) {
      showEasyLoading();

      var result = await _verifyOtpRepo.verifyOtp(
        email: _email,
        code: pinCodeController.text,
      );

      closeEasyLoading();

      result.when(success: (Response response) {
        // Store the reset token from the response
        _resetToken = response.data['resetToken'] ?? '';
        _verifiedCode = pinCodeController.text;

        if (_resetToken.isNotEmpty) {
          // Clear password fields when navigating to new screen
          resetPasswordFields();
          Get.to(() => NewPasswordScreen(
                resetToken: _resetToken,
                email: _email,
                code: _verifiedCode,
              ));
          successEasyLoading(
              response.data["message"] ?? "OTP verified successfully");
        } else {
          errorEasyLoading("Failed to get reset token");
          errorController.add(ErrorAnimationType.shake);
        }
      }, failure: (NetworkExceptions error) {
        errorEasyLoading("Invalid OTP code");
        errorController.add(ErrorAnimationType.shake);
        actionNetworkExceptions(error);
      });
    } else {
      errorEasyLoading("Please enter complete OTP code");
      errorController.add(ErrorAnimationType.shake);
    }
  }

  // Reset password with the reset token
  Future<void> resetPassword({
    required String resetToken,
    required String email,
    required String code,
  }) async {
    if (!areControllersValid) {
      _initTextEditing();
    }

    if (resetPasswordGlobalKey.currentState!.validate() &&
        newPasswordController.text == confirmPasswordController.text) {
      resetPasswordGlobalKey.currentState!.save();
      showEasyLoading();

      var result = await _changePasswordRepo.validateOtpAndChangePassword(
        resetToken: resetToken,
        newPassword: newPasswordController.text,
        confirmNewPassword: confirmPasswordController.text,
      );

      closeEasyLoading();

      result.when(success: (Response response) {
        // Clear all fields after successful password reset
        clearAllFields();
        _verifiedCode = '';
        _resetToken = '';
        Get.offAll(() => const LoginScreen());
        successEasyLoading(
            response.data["message"] ?? "Password reset successfully");
      }, failure: (NetworkExceptions error) {
        actionNetworkExceptions(error);
        errorEasyLoading("Failed to reset password. Please try again.");
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
