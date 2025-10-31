import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  bool passwordChanged = false;
  void passwordChangedSuccessfully() {
    passwordChanged = true;
    update();
  }
}
