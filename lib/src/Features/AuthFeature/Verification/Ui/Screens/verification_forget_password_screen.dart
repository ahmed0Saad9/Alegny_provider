import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
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
  final String email;
  final String token;

  const VerificationForgetPasswordScreen({
    super.key,
    required this.email,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBars.appBarBack(
        title: 'password_recovery',
      ),
      body: GetBuilder<ForgetPasswordController>(
        builder: (_) => SingleChildScrollView(
          padding: AppPadding.paddingScreenSH36,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              40.ESH(),

              // Header Section
              _buildHeaderSection(),

              40.ESH(),

              // OTP Input Card
              _buildOtpCard(context, _),

              32.ESH(),

              // Resend Code Section
              _buildResendSection(_),

              33.ESH(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        CustomTextL(
          'confirm_code',
          fontSize: 28.sp,
        ),

        // Subtitle
        CustomTextL(
          'enter_6_digit_code_sent_to_email',
          fontSize: 16.sp,
        ),

        8.ESH(),

        // Email Display
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.main.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.main.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.email_outlined,
                size: 16.w,
                color: AppColors.main,
              ),
              8.ESW(),
              Text(
                email,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.main,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOtpCard(
      BuildContext context, ForgetPasswordController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // OTP Input
          PinCodeServices.pinCodeWidget(
            context: context,
            pinCodeController: controller.pinCodeController,
            errorController: controller.errorController,
          ),

          24.ESH(),

          // Character Counter
          _buildCharacterCounter(controller),

          32.ESH(),

          // Confirm Button
          ButtonDefault.main(
            onTap: () => controller.checkCode(),
            title: "confirm_code",
            active: controller.pinCodeController.text.length == 6,
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterCounter(ForgetPasswordController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextR(
          '${controller.pinCodeController.text.length}',
          fontSize: 16.sp,
          fontWeight: FW.bold,
          color: AppColors.main,
        ),
        CustomTextL(
          ' / 6',
          fontSize: 14.sp,
          fontWeight: FW.medium,
          color: AppColors.titleGray95,
        ),
        CustomTextL(
          'characters',
          fontSize: 14.sp,
          fontWeight: FW.medium,
          color: AppColors.titleGray95,
        ),
      ],
    );
  }

  Widget _buildResendSection(ForgetPasswordController controller) {
    return Column(
      children: [
        // Resend Code Button
        ResendButton(
          resendCode: () {
            controller.sendOtp(isResendCode: true);
          },
        ),

        16.ESH(),

        // Help Text
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              size: 16.w,
              color: AppColors.titleGray95,
            ),
            8.ESW(),
            CustomTextL(
              'check_spam_folder',
              fontSize: 12.sp,
              color: AppColors.titleGray95,
            ),
          ],
        ),
      ],
    );
  }
}
