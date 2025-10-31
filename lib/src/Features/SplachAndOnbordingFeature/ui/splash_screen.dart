import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/Features/SplachAndOnbordingFeature/bloc/controlelr/splach_controller.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) => Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/Gradiant.png',
              ),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // AnimatedContainer(
              //   curve: Curves.easeInOut,
              //   duration: const Duration(seconds: 1),
              //   width: controller.width.w,
              //   height: controller.height.h,
              //   child: Image.asset(
              //     'assets/images/Logo.png',
              //     // fit: BoxFit.contain,
              //   ),
              // ),
              AnimatedOpacity(
                opacity: controller.isWidgetVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: AnimatedContainer(
                  curve: Curves.easeInOut,
                  duration: const Duration(seconds: 1),
                  width: controller.width.w,
                  height: controller.height.h,
                  child: Image.asset(
                    'assets/images/Logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
