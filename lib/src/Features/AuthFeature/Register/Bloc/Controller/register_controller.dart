import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/LogIn/Ui/Screens/login_screen.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Bloc/Params/register_params.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Bloc/Repo/register_repo.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Ui/Screens/pending_screen.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Verification/Bloc/Controller/send_otp_controller.dart';
import 'package:Alegny_provider/src/core/services/Base/base_controller.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';

class RegisterController extends BaseController<RegisterRepository> {
  @override
  // TODO: implement repository
  get repository => sl<RegisterRepository>();
  final GlobalKey<FormState> registerGlobalKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController idOfCollegeController;
  late TextEditingController nationalIdController;

  var isApproved = false.obs;

  void createAccount() async {
    if (registerGlobalKey.currentState!.validate()) {
      registerGlobalKey.currentState!.save();
      showEasyLoading();
      var result = await repository!.register(
        registerParams: RegisterParams(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          passwordConfirmation: confirmPasswordController.text,
          nationalId: nationalIdController.text,
          idOfCollege: idOfCollegeController.text,
        ),
      );
      closeEasyLoading();
      result.when(success: (Response response) {
        Get.off(
          () => const PendingScreen(),
        );

        successEasyLoading(response.data['message'] ?? "success");
      }, failure: (NetworkExceptions error) {
        actionNetworkExceptions(error);
      });
    }
  }

  void moveToLogIn() {
    Get.off(() => const LoginScreen());
  }

  @override
  void onInit() {
    super.onInit();
    initTextEditingController();
  }

  void initTextEditingController() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    idOfCollegeController = TextEditingController();
    nationalIdController = TextEditingController();
  }
}
