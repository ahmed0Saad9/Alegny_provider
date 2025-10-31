import 'package:Alegny_provider/main.dart';
import 'package:get/get.dart';

abstract class BaseBinding extends Bindings {
  String get tag => Get.currentRoute + kNumOfNav.toString();
}
