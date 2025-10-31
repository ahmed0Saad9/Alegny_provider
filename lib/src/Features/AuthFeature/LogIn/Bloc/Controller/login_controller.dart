import 'package:Alegny_provider/src/Features/AuthFeature/LogIn/Bloc/Repo/login_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/ForgetPassword/Ui/Screens/forget_password_screen.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/LogIn/Bloc/Repo/login_repo.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Bloc/Model/user_model.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Ui/Screens/account_approved_screen.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Ui/Screens/account_denied_screen.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Ui/Screens/pending_screen.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Ui/Screens/register_screen.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Verification/Bloc/Controller/send_otp_controller.dart';
import 'package:Alegny_provider/src/Features/BaseBNBFeature/UI/screens/base_BNB_screen.dart';
import 'package:Alegny_provider/src/core/services/Base/base_controller.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';
import 'package:Alegny_provider/src/core/utils/storage_util.dart';

class LoginController extends BaseController<LogInRepository> {
  @override
  // TODO: implement repository
  get repository => sl<LogInRepository>();
  TextEditingController? emailController;
  TextEditingController? passwordController;
  UserModel? _userModel;
  var rememberMe = false;

  final GlobalKey<FormState> loginGlobalKey = GlobalKey<FormState>();

  Future<void> logIn() async {
    if (loginGlobalKey.currentState!.validate()) {
      loginGlobalKey.currentState!.save();
      showEasyLoading();
      var result = await repository!.logIn(
        password: passwordController!.text,
        email: emailController!.text,
      );
      closeEasyLoading();
      result.when(success: (Response response) {
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
    if (user.student.isApproved) {
      Get.offAll(() => const AccountApprovedScreen());
    }
    // navigatorToBaseBNBScreen();
    successEasyLoading('Welcome to Alegny_provider');
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

  void toggleRememberMe() {
    rememberMe = !rememberMe;
    update();
  }

  @override
  void onInit() {
    super.onInit();

    textControllerInit();
  }

  void textControllerInit() {
    emailController = TextEditingController(text: 'ahmedsaadaboraya@gmail.com');
    passwordController = TextEditingController(text: '987654321sS#');
  }

  @override
  void dispose() {
    emailController?.dispose();
    passwordController?.dispose();
    super.dispose();
  }
}
