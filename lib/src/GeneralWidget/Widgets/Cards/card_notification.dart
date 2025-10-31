import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class CardNotification extends StatelessWidget {
  const CardNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderGreyD0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 16,
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/images/logo.png'),
              backgroundColor: Colors.transparent,
            ),
            10.ESW(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextR.header('P SMART'),
                CustomTextR.subtitle(
                    'استثمر الان في المنتجات الاستثمارية التي تناسبك بضغطة زر'),
              ],
            ),
            const Spacer(),
            CustomTextR.subtitle('1 يوم'),
            6.ESW(),
            CircleAvatar(
              backgroundColor: AppColors.titleRedFF,
              radius: 1.5.r,
            ),
          ],
        ),
      ),
    );
  }
}
