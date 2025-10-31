
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



class CustomIndicatorImages extends StatelessWidget {
  const CustomIndicatorImages({
    super.key,
    required this.pageController,
    required this.count,
    required this.maxWidthIndicator,
  });

  final PageController pageController;
  final int count;
  final double maxWidthIndicator;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              color: Colors.black12.withOpacity(.3),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                // color: Colors.lightGreenAccent,
                constraints: BoxConstraints(
                  maxWidth: maxWidthIndicator,
                ),
                child: FittedBox(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: count,
                    effect: SwapEffect(
                      activeDotColor: Colors.white,
                      dotColor: Colors.white.withOpacity(0.30),
                      dotWidth: 8.w,
                      dotHeight: 8.w,
                      spacing: 8.w,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    ).paddingOnly(bottom: 10.h);
  }
}
