import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/services/svg_widget.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

import '../Text/custom_text.dart';
import 'base_button.dart';

enum ButtonStyle { withBorder, withOutBorder }

class ButtonDefault extends StatelessWidget {
  final String title;
  final String iconSvg;
  final Color? buttonColor;
  final Color disActiveButtonColor;
  final Color titleColor;
  final bool titleColorIsMain;
  final Color? iconColor;
  final VoidCallback? onTap;
  final double height;
  final double width;
  final double radius;
  final double titleSize;
  final double iconSize;
  final Color? borderColor;
  final Color disActiveBorderColor;
  final bool active;
  final Widget? child;
  final bool isLoading;
  final FW fw;
  final double horizontalPadding;
  final double verticalPadding;
  final List<BoxShadow>? boxShadow;

  const ButtonDefault({
    super.key,
    this.isLoading = false,
    this.child,
    this.borderColor,
    this.disActiveButtonColor = AppColors.backGroundButtonMain,
    this.disActiveBorderColor = AppColors.transparentColor,
    this.title = '',
    this.titleSize = 20,
    this.titleColor = AppColors.titleWhite,
    this.fw = FW.medium,
    this.radius = kNButtonRadius12,
    this.iconSize = 24,
    this.iconSvg = '',
    this.buttonColor = AppColors.backGroundButtonMain,
    this.titleColorIsMain = false,
    this.iconColor,
    this.onTap,
    this.height = 62,
    this.width = double.infinity,
    this.active = true,
    this.horizontalPadding = 0,
    this.verticalPadding = 0,
    this.boxShadow,
  });
  const ButtonDefault.main({
    super.key,
    this.isLoading = false,
    this.child,
    this.borderColor,
    this.disActiveButtonColor = AppColors.backGroundButtonMain,
    this.disActiveBorderColor = AppColors.transparentColor,
    this.title = '',
    this.titleSize = 20,
    this.titleColor = AppColors.titleWhite,
    this.fw = FW.medium,
    this.radius = kNButtonRadius12,
    this.iconSize = 24,
    this.iconSvg = '',
    this.buttonColor = AppColors.backGroundButtonMain,
    this.titleColorIsMain = false,
    this.iconColor,
    this.onTap,
    this.height = 62,
    this.width = double.infinity,
    this.active = true,
    this.horizontalPadding = 0,
    this.verticalPadding = 0,
    this.boxShadow,
  });

  const ButtonDefault.white({
    super.key,
    this.isLoading = false,
    this.child,
    this.borderColor = AppColors.borderGreen,
    this.disActiveButtonColor = AppColors.transparentColor,
    this.disActiveBorderColor = AppColors.backGroundButtonMain,
    this.title = '',
    this.titleSize = 14,
    this.titleColor = AppColors.titleMain,
    this.fw = FW.medium,
    this.radius = kNButtonRadius12,
    this.iconSize = 24,
    this.iconSvg = '',
    this.buttonColor = AppColors.backGroundButtonGrey,
    this.titleColorIsMain = false,
    this.iconColor,
    this.onTap,
    this.height = 48,
    this.width = double.infinity,
    this.active = true,
    this.horizontalPadding = 0,
    this.verticalPadding = 0,
    this.boxShadow,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      child: BaseButton(
        height: height.h,
        width: width.w,
        radius: radius.r,
        borderColor: active ? borderColor : disActiveBorderColor,
        buttonColor: active
            ? buttonColor != null
                ? buttonColor!
                : AppColors.backGroundButtonMain
            : disActiveButtonColor.withOpacity(0.5),
        onTap: () {
          if (active) onTap!();
        },
        boxShadow: boxShadow,
        child: child ?? drawChild(),
      ),
    );
  }

  Widget drawChild() {
    if (title.isNotEmpty && iconSvg.isEmpty) {
      // TODO return text only
      return Center(
        child: CustomTextL(
          title,
          color: titleColorIsMain ? AppColors.titleBlack0B : titleColor,
          fontSize: titleSize,
          fontWeight: fw,
        ),
      );
    } else if (title.isEmpty && iconSvg.isNotEmpty) {
      // TODO return icon only
      return Center(
        child: IconSvg(
          iconSvg,
          color: iconColor,
          size: iconSize,
        ),
      );
    } else if (title.isNotEmpty && iconSvg.isNotEmpty) {
      // TODO return icon and text
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isLoading
                ? SizedBox(
                    height: 12.h,
                    width: 12.h,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.w,
                    ),
                  )
                : IconSvg(
                    iconSvg,
                    color: iconColor,
                    size: iconSize,
                  ),
            7.0.ESW(),
            CustomTextL(
              title,
              color: titleColor,
              fontSize: titleSize,
              fontWeight: fw,
            ),
          ],
        ),
      );
    } else {
      // TODO return text only
      return Center(
        child: CustomTextL(
          title,
          color: titleColor,
          fontSize: titleSize,
          fontWeight: fw,
        ),
      );
    }
  }
}
