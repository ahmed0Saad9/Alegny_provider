import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';

import '../../../core/constants/app_assets.dart';

class BaseButton extends StatelessWidget {
  final Color? buttonColor;
  final VoidCallback? onTap;
  final double height;
  final double width;
  final Color? borderColor;
  final double radius;
  final Widget? child;
  final List<BoxShadow>? boxShadow;

  const BaseButton({
    super.key,
    this.borderColor,
    this.child,
    this.radius = kNButtonRadius44,
    this.buttonColor,
    this.onTap,
    this.height = 54,
    this.width = 343,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            printDM('hello this tap in button');
          },
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius.r),
            border: Border.all(
                color: borderColor ?? Colors.transparent,
                width: borderColor != null ? 1 : 0),
            color: buttonColor,
            boxShadow: boxShadow),
        child: child ?? const Center(),
      ),
    );
  }
}
