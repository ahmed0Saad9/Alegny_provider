import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

import '../../../core/constants/sizes.dart';
import '../Text/custom_text.dart';

class NoAvailableDataWithbutton extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String buttonTitle;
  final double imageHeight;
  final double imageWidth;
  final VoidCallback ontap;

  const NoAvailableDataWithbutton({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.imageHeight,
    required this.imageWidth,
    required this.buttonTitle,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.paddingScreenSH16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: imageWidth.w,
            height: imageHeight.h,
            fit: BoxFit.fill,
          ),
          19.ESH(),
          CustomTextL(
            title,
            fontSize: 19,
            color: AppColors.titleBlack1F,
          ),
          CustomTextL(
            subtitle,
            fontSize: 15,
            color: AppColors.titleGray70,
            textAlign: TextAlign.center,
          ),
          24.ESH(),
          ButtonDefault.main(
            width: 135.w,
            height: 40.h,
            title: buttonTitle,
            titleSize: 14,
            titleColor: AppColors.titleBlack0B,
            buttonColor: AppColors.darkBackGroung.withOpacity(0.10),
            borderColor: AppColors.borderBlack0B,
            onTap: ontap,
          ),
        ],
      ),
    );
  }
}
