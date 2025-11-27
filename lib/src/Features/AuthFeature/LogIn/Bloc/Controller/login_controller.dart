import 'package:Alegny_provider/src/Features/AuthFeature/LogIn/Bloc/Repo/login_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/ForgetPassword/Ui/Screens/forget_password_screen.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/LogIn/Bloc/Repo/login_repo.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Bloc/Model/user_model.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Ui/Screens/register_screen.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Verification/Bloc/Controller/send_otp_controller.dart';
import 'package:Alegny_provider/src/Features/BaseBNBFeature/UI/screens/base_BNB_screen.dart';
import 'package:Alegny_provider/src/core/services/Base/base_controller.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';
import 'package:Alegny_provider/src/core/utils/storage_util.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends BaseController<LogInRepository> {
  @override
  // TODO: implement repository
  get repository => sl<LogInRepository>();
  TextEditingController? emailController;
  TextEditingController? passwordController;
  UserModel? _userModel;
  RxBool rememberMe = false.obs;

  final GlobalKey<FormState> loginGlobalKey = GlobalKey<FormState>();

  Future<void> logIn() async {
    // Get.off(() => BaseBNBScreen());
    if (loginGlobalKey.currentState!.validate()) {
      loginGlobalKey.currentState!.save();
      showEasyLoading();
      var result = await repository!.logIn(
        password: passwordController!.text,
        email: emailController!.text,
      );
      closeEasyLoading();
      result.when(success: (Response response) {
        if (rememberMe.value) {
          TextInput.finishAutofillContext();
        } else {
          // Clear: do NOT save login info
          TextInput.finishAutofillContext(shouldSave: false);
        }
        _userModel = UserModel.fromJson(response.data);
        LocalStorageCubit().storeUserModel(
            _userModel!); //stores the user data locally by GetStorage
        _navigatorAfterLogIn(_userModel!);
      }, failure: (NetworkExceptions error) {
        actionNetworkExceptions(error);
      });
    }
  }

  void navigatorToBaseBNBScreen() {
    Get.offAll(() => const BaseBNBScreen());
  }

  /// check OTP is Verified
  final SendOTPController _sendOTPController = sl<SendOTPController>();

  void _navigatorAfterLogIn(UserModel user) async {
    navigatorToBaseBNBScreen();
    successEasyLoading('Welcome_to_Alegny'.tr);
    // }
  }

  /// move To Forget Password
  void moveToForgetPassword() {
    Get.to(() => const ForgetPasswordScreen());
  }

  /// move To Register
  void moveToRegister() {
    Get.off(() => const RegisterScreen());
  }

  @override
  void onInit() {
    super.onInit();

    textControllerInit();
  }

  void textControllerInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController?.dispose();
    passwordController?.dispose();
    super.dispose();
  }
}
