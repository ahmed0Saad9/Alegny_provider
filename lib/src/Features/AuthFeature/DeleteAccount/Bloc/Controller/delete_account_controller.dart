import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/DeleteAccount/Bloc/Repo/delete_account_repo.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/LogIn/Ui/Screens/login_screen.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Loading/loading_dialog.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';

class DeleteAccountController extends GetxController {
  final DeleteAccountRepository _deleteAccountRepository =
      sl<DeleteAccountRepository>();

  Future<void> deleteAccount() async {
    setLoading();

    var result = await _deleteAccountRepository.deleteAccount();
    Get.back();
    result.when(success: (Response response) {
      sl<GetStorage>().erase();
      Get.offAll(() => const LoginScreen());
    }, failure: (NetworkExceptions error) {
      actionNetworkExceptions(error);
    });
  }
}
