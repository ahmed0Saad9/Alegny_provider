import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class SocialCard extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const SocialCard({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 171.w,
        padding: EdgeInsets.symmetric(vertical: 17.h),
        decoration: BoxDecoration(
          color: AppColors.backGroundWhite,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: AppColors.cardShadowBlack,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            image,
            height: 19.h,
            width: 18,
          ),
          13.ESW(),
          CustomTextL.subtitle(
            title,
            fontWeight: FW.light,
            fontSize: 16.sp,
          ),
        ]),
      ),
    );
  }
}
