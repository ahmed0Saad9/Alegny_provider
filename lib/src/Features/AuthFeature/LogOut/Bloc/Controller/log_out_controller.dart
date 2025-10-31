import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/LogIn/Ui/Screens/login_screen.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/LogOut/Bloc/Repo/log_out_repo.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';

class LogOutController extends GetxController {
  final LogOutRepository _logOutRepository = sl<LogOutRepository>();

  Future<void> logOut() async {
    _logOutRepository.logOut();

    sl<GetStorage>().erase();
    Get.offAll(() => const LoginScreen());
  }
}
