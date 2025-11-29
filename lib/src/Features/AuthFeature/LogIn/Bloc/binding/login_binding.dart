import 'package:Alegny_provider/src/Features/AuthFeature/LogIn/Bloc/Controller/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
