import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/LogIn/Bloc/Controller/login_controller.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/services/svg_widget.dart';

import '/src/core/utils/extensions.dart';

class LoginWithWidget extends StatelessWidget {
  final LoginController controller;

  const LoginWithWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  color: AppColors.dividerGray,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: const CustomTextL(
                'login_with',
                fontSize: 15,
                fontWeight: FW.medium,
                color: AppColors.titleGray7A,
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  color: AppColors.dividerGray,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
        22.ESH(),
        Row(
          children: [
            _Card(
              onTap: () {},
              icon: 'google',
            ),
            16.ESW(),
            _Card(
              onTap: () {},
              icon: 'facebook',
            ),
          ],
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final VoidCallback onTap;
  final String icon;
  const _Card({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 17.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.r),
            border: Border.all(color: AppColors.borderGrey),
          ),
          child: Center(
            child: IconSvg(
              icon,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
