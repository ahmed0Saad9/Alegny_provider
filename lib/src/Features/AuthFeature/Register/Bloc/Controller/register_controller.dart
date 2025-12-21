import 'package:Alegny_provider/src/Features/AuthFeature/Register/Bloc/Model/user_model.dart';
import 'package:Alegny_provider/src/Features/BaseBNBFeature/UI/screens/base_BNB_screen.dart';
import 'package:Alegny_provider/src/core/utils/storage_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/LogIn/Ui/Screens/login_screen.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Bloc/Params/register_params.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Bloc/Repo/register_repo.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Verification/Bloc/Controller/send_otp_controller.dart';
import 'package:Alegny_provider/src/core/services/Base/base_controller.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';

class RegisterController extends BaseController<RegisterRepository> {
  @override
  get repository => sl<RegisterRepository>();

  final GlobalKey<FormState> registerGlobalKey = GlobalKey<FormState>();
  var acceptTermsAndConditions = false;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController phoneController;
  UserModel? _userModel;

  void createAccount() async {
    if (registerGlobalKey.currentState!.validate()) {
      registerGlobalKey.currentState!.save();
      showEasyLoading();

      var result = await repository!.register(
        registerParams: RegisterParams(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          password: passwordController.text,
          phoneNumber: phoneController.text,
        ),
      );

      closeEasyLoading();

      result.when(success: (Response response) {
        // ✅ Tell OS to save credentials to system password manager
        // This will prompt: "Save password for Alegny?"
        TextInput.finishAutofillContext(shouldSave: true);

        _userModel = UserModel.fromJson(response.data);
        LocalStorageCubit().storeUserModel(_userModel!);

        Get.off(() => const BaseBNBScreen());
        successEasyLoading(response.data['message'] ?? "success");
      }, failure: (NetworkExceptions error) {
        // Don't save if registration fails
        TextInput.finishAutofillContext(shouldSave: false);
        actionNetworkExceptions(error);
      });
    }
  }

  void toggleAcceptTermsAndConditions() {
    acceptTermsAndConditions = !acceptTermsAndConditions;
    update();
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
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
