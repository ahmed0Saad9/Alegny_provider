import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/ForgetPassword/Ui/Widgets/bottom_resend_code.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Verification/Bloc/Controller/send_otp_controller.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Verification/Bloc/Controller/verify_otp_controller.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/services/pin_code.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';

class PinFieldWidget extends StatelessWidget {
  final String phone;
  // final String token;

  const PinFieldWidget({
    super.key,
    required this.phone,
    // required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 28.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.wight,
      ),
      child: GetBuilder<VerifyOTPController>(
        init: VerifyOTPController(),
        builder: (_) => Column(
          children: [
            PinCodeServices.pinCodeWidget(
              context: context,
              pinCodeController: _.textEditingController,
              errorController: _.errorController,
            ),
            ResendButton(
              resendCode: () {
                sl<SendOTPController>().sendOTP(
                  email: phone,
                  inVerificationScreen: true,
                  verifyAccount: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
