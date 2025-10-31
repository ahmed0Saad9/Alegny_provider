import 'package:Alegny_provider/src/Features/AccountFeature/Bloc/Model/account_details_model.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/services/svg_widget.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ListPersonalData extends StatelessWidget {
  final Profile userData;

  const ListPersonalData({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PersonalData(
            icon: 'Profile', label: 'Full_Name', data: userData.fullName),
        const Divider(
          color: AppColors.dividerGrayD0,
          height: 0,
          thickness: 0.5,
        ),
        PersonalData(
          icon: 'Email',
          label: 'Email',
          data: userData.email,
        ),
        const Divider(
          color: AppColors.dividerGrayD0,
          height: 0,
          thickness: 0.5,
        ),
        PersonalData(
          icon: 'CollegeID',
          label: 'College_ID',
          data: userData.universityIDCard,
        ),
        const Divider(
          color: AppColors.dividerGrayD0,
          height: 0,
          thickness: 0.5,
        ),
        PersonalData(
          icon: 'NationalID',
          label: 'National_ID',
          data: userData.nationalIDCard,
        ),
        const Divider(
          color: AppColors.dividerGrayD0,
          height: 0,
          thickness: 0.5,
        ),
      ],
    );
  }
}

class PersonalData extends StatelessWidget {
  final String icon;
  final String label;
  final String data;

  const PersonalData({
    super.key,
    required this.icon,
    required this.label,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: Get.width,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconSvg(
              icon,
              color: AppColors.iconGray95,
              size: 20,
              boxFit: BoxFit.fill,
            ),
            6.ESW(),
            CustomTextL.title(
              label,
              fontSize: 14,
              color: AppColors.titleGray54,
            ),
            const Spacer(),
            CustomTextR(
              data,
              fontSize: 14,
              color: AppColors.titleMain,
            ),
          ],
        ),
      ),
    );
  }
}
