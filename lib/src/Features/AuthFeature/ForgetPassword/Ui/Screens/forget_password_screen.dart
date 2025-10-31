import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/ForgetPassword/Bloc/Controller/forget_password_controller.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/ForgetPassword/Ui/Screens/pin_code.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/ForgetPassword/Ui/Widgets/forget_password_body.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Appbars/app_bars.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/top_custom_container.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/base_scaffold.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/custom_stepper.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/TextFields/text_field_default.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:Alegny_provider/src/core/utils/validator.dart';

import '../../../../../GeneralWidget/Widgets/Text/custom_text.dart';
import '../../../../../core/constants/color_constants.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<ForgetPasswordController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ForgetPasswordController());
    var node = FocusScope.of(context);
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.scaffoldBackGround,
        image: DecorationImage(
            image: AssetImage('assets/images/Gradiant.png'), fit: BoxFit.cover),
      ),
      padding: AppPadding.paddingScreenSH36,
      child: BaseScaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBars.appBarBack(title: 'Forget_password'),
          body: GetBuilder<ForgetPasswordController>(
            init: ForgetPasswordController(),
            builder: (_) => Form(
              key: _.globalKey,
              child: Column(children: [
                30.ESH(),
                CustomTextL.subtitle(
                  'Forget_password_subtitle',
                  fontWeight: FW.medium,
                  textAlign: TextAlign.center,
                ),
                40.ESH(),
                TextFieldDefault(
                  label: 'Email',
                  controller: _.emailController,
                  validation: emailValidator,
                  keyboardType: TextInputType.emailAddress,
                  onComplete: () {
                    node.unfocus();
                  },
                ),
                const Spacer(),
                ButtonDefault.main(
                  title: 'Continue',
                  active: _.emailController.text.isNotEmpty,
                  onTap: () {
                    _.checkEmailAndSendOtp();
                    // Get.bottomSheet(BottomSheetSendOTP(), isScrollControlled: true);
                  },
                ),
                33.ESH(),
              ]),
            ),
          )),
    );
  }
}
