import 'dart:async';
import 'package:Alegny_provider/src/Features/AuthFeature/LogIn/Ui/Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  Timer? _animationTimer;
  Timer? _visibleTimer;
  Timer? _splashTimer;
  @override
  void onInit() async {
    super.onInit();
    _splashTimer = Timer(const Duration(seconds: 4), () {
      moveToLogin();
    });
    _animationTimer = Timer(const Duration(seconds: 2), () {
      triggerAnimation();
    });
    _visibleTimer = Timer(const Duration(seconds: 2), () {
      toggleVisibility();
    });
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
