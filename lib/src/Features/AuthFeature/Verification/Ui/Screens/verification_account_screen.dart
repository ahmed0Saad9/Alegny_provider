import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Verification/Bloc/Controller/verify_otp_controller.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Appbars/app_bars.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/base_scaffold.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/services/pin_code.dart';

import '/src/core/utils/extensions.dart';

class VerificationAccountScreen extends StatelessWidget {
  final String token;
  final String email;

  const VerificationAccountScreen({
    super.key,
    required this.token,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyOTPController>(
      init: VerifyOTPController(),
      builder: (_) => BaseScaffold(
        appBar: AppBars.appBarBack(
          title: 'OTP',
        ),
        body: Padding(
          padding: AppPadding.paddingScreenSH36,
          child: Column(
            children: [
              const CustomTextL(
                'Enter 4 Digits Code',
                fontSize: 28,
                fontWeight: FW.bold,
              ),
              8.ESH(),
              CustomTextL.subtitle(
                'Enter the 4 digits code that you received on\nyour email.',
                fontWeight: FW.medium,
                textAlign: TextAlign.center,
              ),
              40.ESH(),
              PinCodeServices.pinCodeWidget(
                fieldCounts: 4,
                context: context,
                pinCodeController: _.textEditingController,
                errorController: _.errorController,
              ),
              const Spacer(),
              ButtonDefault.main(
                title: 'confirm',
                verticalPadding: 16,
                onTap: () {
                  _.verify(token: token);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
