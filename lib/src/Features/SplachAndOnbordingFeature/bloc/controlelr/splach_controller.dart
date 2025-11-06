import 'dart:async';
import 'package:Alegny_provider/src/Features/AuthFeature/LogIn/Ui/Screens/login_screen.dart';
import 'package:Alegny_provider/src/Features/BaseBNBFeature/UI/screens/base_BNB_screen.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  Timer? _animationTimer;
  Timer? _visibleTimer;
  Timer? _splashTimer;
  @override
  void onInit() async {
    super.onInit();
    _splashTimer = Timer(const Duration(seconds: 4), () async {
      if (await _isLogged()) {
        _navigatorAfterLogIn();
      } else {
        moveToLogin();
      }
    });
    _animationTimer = Timer(const Duration(seconds: 2), () {
      triggerAnimation();
    });
    _visibleTimer = Timer(const Duration(seconds: 2), () {
      toggleVisibility();
    });
  }

  final _box = sl<GetStorage>();
  Future<bool> _isLogged() async {
    return (_box.read('token') != null && _box.read('token') != "");
  }

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void _navigatorAfterLogIn() {
    Get.offAll(() => const BaseBNBScreen());
  }

  var width = 300.0;
  var height = 350.0;
  var alignmentLogo = Alignment.center;

  void triggerAnimation() {
    width = 200;
    height = 250;
    alignmentLogo = Alignment.centerLeft;
    update();
  }

  bool isWidgetVisible = false;
  var alignmentMETLogo = Alignment.centerRight;

  void toggleVisibility() {
    isWidgetVisible = !isWidgetVisible;

    update();
  }

  void moveToLogin() {
    Get.off(() => LoginScreen());
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _animationTimer?.cancel();
    _visibleTimer?.cancel();
  }
}
