import 'package:Alegny_provider/src/core/services/Base/base_controller.dart';

class BController extends BaseController {
  @override
  // TODO: implement repository
  // get repository => sl<>();
  get repository => throw UnimplementedError();

  Future<void> logIn() async {
    showLoading();
    // var result = await _logInRepository.logIn(
    //   userName: phoneController!.text,
    //   password: passwordController!.text,
    // );
    doneLoading();
    update();
    // result.when(success: (Response response) {
    //   _userModel = BaseUserModel.fromJson(response.data);
    //   LocalStorageCubit().storeUserModel(response.data);
    //   _navigatorAfterLogIn(_userModel!.data.user);
    // }, failure: (NetworkExceptions error) {
    //   Get.back();
    //   actionNetworkExceptions(error);
    // });
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
