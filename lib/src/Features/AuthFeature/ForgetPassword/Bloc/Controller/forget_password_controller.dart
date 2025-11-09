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

  TextEditingController pinCodeController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetPasswordGlobalKey = GlobalKey<FormState>();

  String _token = '';
  String _email = '';

  final ValidateOtpAndChangePasswordRepo _validateOtpAndChangePasswordRepo =
      sl<ValidateOtpAndChangePasswordRepo>();

  // Send OTP for password reset - FIXED METHOD NAME
  Future<void> sendOtp({bool isResendCode = false}) async {
    if (globalKey.currentState!.validate()) {
      globalKey.currentState!.save();
      showEasyLoading();

      var result = await repository!.checkEmailAndSendOtp(
          email: emailController.text); // FIXED: checkEmailAndSendOtp
      closeEasyLoading();

      result.when(success: (Response response) {
        _token = response.data['data']['verify_token'] ?? '';
        _email = emailController.text;

        if (!isResendCode) {
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

  // Verify OTP code
  void checkCode() {
    if (pinCodeController.text.length == 4) {
      Get.to(() => NewPasswordScreen(
            token: _token,
            email: _email,
            code: pinCodeController.text,
          ));
    } else {
      errorEasyLoading("Please enter complete OTP code");
    }
  }

  // Reset password with OTP - FIXED METHOD CALL
  Future<void> resetPassword({
    required String token,
    required String email,
    required String code,
  }) async {
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
        Get.offAll(() => const LoginScreen());
        successEasyLoading(
            response.data["message"] ?? "Password reset successfully");
      }, failure: (NetworkExceptions error) {
        actionNetworkExceptions(error);
      });
    } else {
      errorEasyLoading("Passwords do not match");
    }
  }

  // Alternative method name that matches your original call
  Future<void> checkEmailAndSendOtp({bool isResendCode = false}) async {
    await sendOtp(isResendCode: isResendCode);
  }

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
  }

  @override
  void onClose() {
    _disposeTextEditing();
    super.onClose();
  }

  void _disposeTextEditing() {
    pinCodeController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    errorController.close();
  }
}
