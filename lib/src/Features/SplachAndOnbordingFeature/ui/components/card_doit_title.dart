import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class CardDoitTitle extends StatelessWidget {
  final String title;
  const CardDoitTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CustomTextL(
              title,
              fontSize: 20,
              fontWeight: FW.bold,
              textAlign: TextAlign.end,
            ),
          ),
          8.ESW(),
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child:
                CircleAvatar(radius: 7.r, backgroundColor: AppColors.secondary),
          ),
        ],
      ),
    );
  }
}
