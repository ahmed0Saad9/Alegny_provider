import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/ForgetPassword/Bloc/Controller/forget_password_controller.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/ForgetPassword/Ui/Widgets/bottom_resend_code.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Verification/Ui/widgets/verification_top_widget.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Appbars/app_bars.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/base_scaffold.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/services/pin_code.dart';

import '/src/core/utils/extensions.dart';

class VerificationForgetPasswordScreen extends StatelessWidget {
  // final String phone;
  final String email;
  final String token;

  const VerificationForgetPasswordScreen({
    super.key,
    // required this.phone,
    required this.email,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBars.appBarDefault(),
      body: GetBuilder<ForgetPasswordController>(
        builder: (_) => Container(
          padding: AppPadding.paddingScreenSH16,
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            children: [
              40.ESH(),
              VerificationTopWidget(
                title: 'استرجاع كلمة المرور',
                // phone: phone,
                email: email,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.w),
                child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 28.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.wight,
                  ),
                  child: Column(
                    children: [
                      PinCodeServices.pinCodeWidget(
                        context: context,
                        pinCodeController: _.pinCodeController,
                        errorController: _.errorController,
                      ),
                      88.ESH(),
                      ButtonDefault.main(
                        onTap: () => _.checkCode(),
                        title: "تأكيد",
                      ),
                    ],
                  ),
                ),
              ),
              16.ESH(),
              ResendButton(
                resendCode: () {},
              ),
              8.ESH(),
            ],
          ),
        ),
      ),
    );
  }
}
