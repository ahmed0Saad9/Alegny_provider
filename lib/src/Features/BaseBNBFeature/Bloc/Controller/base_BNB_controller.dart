import 'package:get/get.dart';

class BaseNBNController extends GetxController {
  var bottomNavIndex = 1; //default index of a first screen

  void updateIndex(int index) {
    bottomNavIndex = index;
    update();
  }

  Future<bool> willPopCallback() async {
    if (bottomNavIndex != 0) {
      bottomNavIndex = 0;
      update();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
