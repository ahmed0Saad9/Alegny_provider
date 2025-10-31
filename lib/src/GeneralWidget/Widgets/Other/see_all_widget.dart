import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/services/svg_widget.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class SeeAllWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const SeeAllWidget({
    required this.title,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h, right: 22.w, left: 22.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextL.header(
            title,
            fontSize: 14,
            fontWeight: FW.medium,
          ),
          onTap == null
              ? 0.ESW()
              : InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(4.r),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        CustomTextL(
                          "See_All",
                          fontSize: 12,
                          fontWeight: FW.medium,
                        ),
                        IconSvg(
                          "arrow_go",
                          color: AppColors.iconBlack,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
