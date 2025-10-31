import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/custom_stepper.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/services/svg_widget.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class TopCustomContainer extends StatelessWidget {
  final String? icon;
  final bool? withIcon;
  final String title;
  final String subTitle;
  const TopCustomContainer({
    super.key,
    this.icon,
    required this.title,
    required this.subTitle,
    this.withIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backGroundGreyFD,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          50.ESH(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                withIcon!
                    ? Row(
                        children: [
                          IconSvg(
                            icon!,
                          ),
                          10.ESW(),
                        ],
                      )
                    : 0.0.ESH(),
                CustomTextL.title(
                  title,
                  fontSize: 18,
                  fontWeight: FW.bold,
                  color: AppColors.titleBlack1A,
                ),
                const Spacer(),
                InkWell(
                  onTap: () => Get.back(),
                  child: Row(
                    children: [
                      const CustomTextL(
                        'back',
                        fontSize: 14,
                        fontWeight: FW.bold,
                      ),
                      4.ESW(),
                      const IconSvg('back'),
                    ],
                  ),
                )
              ],
            ),
          ),
          6.ESH(),
          if (subTitle != '')
            CustomTextL.subtitle(
              subTitle,
              padding: AppPadding.paddingScreenSH16,
            ),
          const MainDivider(),
        ],
      ),
    );
  }
}
