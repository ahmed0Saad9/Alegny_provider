import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/ForgetPassword/Bloc/Controller/forget_password_controller.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/ForgetPassword/Ui/Widgets/bottom_resend_code.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Appbars/app_bars.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/base_scaffold.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/StaggeredAnimations/base_column.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/services/pin_code.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class PinCodeScreen extends StatelessWidget {
  final String title;

  const PinCodeScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.scaffoldBackGround,
        image: DecorationImage(
            image: AssetImage('assets/images/Gradiant.png'), fit: BoxFit.cover),
      ),
      padding: AppPadding.paddingScreenSH36,
      child: BaseScaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBars.appBarBack(
          title: title,
        ),
        body: GetBuilder<ForgetPasswordController>(
          builder: (_) =>
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            50.ESH(),
            const CustomTextL(
              'Enter_code',
              fontSize: 28,
              fontWeight: FW.bold,
              textAlign: TextAlign.center,
            ),
            8.ESH(),
            CustomTextL.subtitle(
              'Enter_code_subtitle',
              fontWeight: FW.medium,
            ),
            40.ESH(),
            PinCodeServices.pinCodeWidget(
                context: context,
                pinCodeController: _.pinCodeController,
                errorController: _.errorController),
            40.ESH(),
            const Spacer(),
            ButtonDefault.main(
              title: 'Continue',
              onTap: () {
                _.checkCode();
              },
            ),
            33.ESH(),
          ]),
        ),
      ),
    );
  }
}
