import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

import '../../../core/constants/color_constants.dart';
import '../Text/custom_text.dart';

class CardClient extends StatelessWidget {
  const CardClient({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          SizedBox(),
          isScrollControlled: true,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(color: AppColors.borderGreyE1)),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset('assets/images/client.png'),
            ),
            12.ESW(),
            const CustomTextR(
              'احمد سعد ابوريه',
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
