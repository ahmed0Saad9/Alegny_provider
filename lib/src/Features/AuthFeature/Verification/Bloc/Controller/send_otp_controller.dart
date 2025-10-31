import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Verification/Bloc/Repo/send_otp_repository.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Verification/Ui/Screens/verification_account_screen.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Verification/Ui/Screens/verification_forget_password_screen.dart';
import 'package:Alegny_provider/src/core/services/Base/base_controller.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';

class SendOTPController extends BaseController<SendOTPRepository> {
  @override
  // TODO: implement repository
  get repository => sl<SendOTPRepository>();

  Future<void> sendOTP(
      {
      // required String phone,
      required String email,
      bool inVerificationScreen = false,
      bool verifyAccount = false}) async {
    showEasyLoading();
    var result = await repository!.sendOTP(email: email);
    closeEasyLoading();
    result.when(success: (Response response) {
      if (verifyAccount) {
        if (!inVerificationScreen) {
          Get.to(
            () => VerificationAccountScreen(
              email: email,
              token: response.data['data']['verify_token'],
            ),
          );
        }
      } else {
        if (!inVerificationScreen) {
          Get.to(
            () => VerificationForgetPasswordScreen(
              // phone: phone,
              email: email,
              token: response.data['data']['verify_token'],
            ),
          );
        }
      }
      showMessage(response.data['message'] ?? '', isError: false);
    }, failure: (NetworkExceptions error) {
      actionNetworkExceptions(error);
    });
  }
}
