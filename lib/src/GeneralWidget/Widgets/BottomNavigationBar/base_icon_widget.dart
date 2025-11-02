import 'package:flutter/material.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/services/svg_widget.dart';
import '../Text/custom_text.dart';

class BaseIconWidget extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;
  final bool active;

  const BaseIconWidget({
    super.key,
    required this.onTap,
    this.active = false,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
                color: active ? AppColors.main : AppColors.transparentColor,
                borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: IconSvg(
                icon,
                size: 20,
                color: active ? AppColors.iconWight : AppColors.iconBlack,
                boxFit: BoxFit.fill,
              ),
            ),
          ),
          // 3.ESH(),
          CustomTextL(
            title,
            color: active ? AppColors.main : AppColors.titleBlack,
            fontWeight: active ? FW.bold : FW.medium,
            fontSize: 14,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
