import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/LogIn/Ui/Screens/login_screen.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/StaggeredAnimations/base_column.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class DataSuccessScreen extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final String? note;

  const DataSuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      this.note});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: AppColors.backGroundGreyFD,
        child: BaseStaggeredColumn(
          children: [
            100.ESH(),
            Image.asset(
              image,
              height: 350.h,
              // width: 350.w,
            ),
            14.ESH(),
            CustomTextL.header(
              title,
              color: AppColors.titleGreen,
            ),
            14.ESH(),
            SizedBox(
              width: 251,
              child: CustomTextL(
                subTitle,
                fontSize: 16,
                fontWeight: FW.medium,
                textAlign: TextAlign.center,
                color: AppColors.titleGray62,
              ),
            ),
            14.ESH(),
            if (note != null)
              CustomTextL(
                note!,
                fontSize: 16,
                fontWeight: FW.bold,
                color: AppColors.titleGray95,
              ),
          ],
        ),
      ),
    );
  }
}
