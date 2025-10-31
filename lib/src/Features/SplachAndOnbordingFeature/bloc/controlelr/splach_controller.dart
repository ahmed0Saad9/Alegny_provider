import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  Timer? _animationTimer;
  Timer? _visibleTimer;
  @override
  void onInit() async {
    super.onInit();
    _animationTimer = Timer(const Duration(seconds: 2), () {
      triggerAnimation();
    });
    _visibleTimer = Timer(const Duration(seconds: 3), () {
      toggleVisibility();
    });
  }

  var width = 250.0;
  var height = 300.0;
  var alignmentLogo = Alignment.center;

  void triggerAnimation() {
    width = 150;
    height = 200;
    alignmentLogo = Alignment.centerLeft;
    update();
  }

  bool isWidgetVisible = false;
  var alignmentMETLogo = Alignment.centerRight;

  void toggleVisibility() {
    isWidgetVisible = !isWidgetVisible;

    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _animationTimer?.cancel();
    _visibleTimer?.cancel();
  }
}
