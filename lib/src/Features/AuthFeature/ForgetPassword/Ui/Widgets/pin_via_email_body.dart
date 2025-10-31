import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/ForgetPassword/Bloc/Controller/forget_password_controller.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Verification/Ui/widgets/pin_field_widget.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class PINViaEmailBody extends StatelessWidget {
  final ForgetPasswordController controller;

  const PINViaEmailBody({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.paddingScreenSH16,
      color: AppColors.backGroundGreyFD,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              CustomTextL.title(
                'verify_your_account',
              ),
            ],
          ),
          14.0.ESH(),
          Image.asset(
            'assets/images/AccountVerification.png',
            width: 295.w,
            height: 287.h,
          ),
          14.ESH(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextL.subtitle(
                'we_will_send_verification_code_to_your_account',
              ),
              4.ESH(),
              CustomTextR.subtitle(
                'ahmedsaad@gmail.com',
                fontWeight: FW.bold,
              ),
              4.ESH(),
              CustomTextL.subtitle(
                'please_type_this_code_below_for_the_next_step',
              ),
              14.ESH(),
              PinFieldWidget(
                phone: '01122982156',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
