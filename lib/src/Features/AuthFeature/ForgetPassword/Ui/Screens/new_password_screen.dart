import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/ForgetPassword/Bloc/Controller/forget_password_controller.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Appbars/app_bars.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/base_scaffold.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

import '../../../../../GeneralWidget/Widgets/Text/custom_text.dart';
import '../../../../../GeneralWidget/Widgets/TextFields/text_field_default.dart';
import '../../../../../core/constants/color_constants.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/services/svg_widget.dart';
import '../../../../../core/utils/validator.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        appBar: AppBars.appBarBack(title: 'change_password'),
        body: Form(
          // key: _.resetPasswordGlobalKey,
          child: GetBuilder<ForgetPasswordController>(
            builder: (_) =>
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              40.ESH(),
              const CustomTextL(
                'Reset_Password',
                fontSize: 28,
                fontWeight: FW.bold,
              ),
              8.ESH(),
              CustomTextL.subtitle(
                'Reset_Password_subtitle',
                fontWeight: FW.medium,
              ),
              40.ESH(),
              TextFieldDefault(
                label: 'new_Password',
                controller: _.newPasswordController,
                validation: passwordValidator,
                secureType: SecureType.toggle,
                onComplete: () {
                  node.nextFocus();
                },
              ),
              24.ESH(),
              TextFieldDefault(
                label: 'Re_Enter_Password',
                controller: _.confirmPasswordController,
                validation: (value) {
                  return confirmPasswordValidator(
                      value, _.newPasswordController.text);
                },
                secureType: SecureType.toggle,
                onComplete: () {
                  node.unfocus();
                },
              ),
              const Spacer(),
              ButtonDefault.main(
                title: 'Continue',
                onTap: () {
                  _.validateOtpAndChangePassword();
                },
              ),
              33.ESH(),
            ]),
          ),
        ),
      ),
    );
  }
}

class PasswordCheck extends StatelessWidget {
  const PasswordCheck({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          const IconSvg('check'),
          CustomTextL(
            label,
            color: AppColors.titleGrayAF,
            fontSize: 12,
            textAlign: TextAlign.right,
          )
        ],
      ),
    );
  }
}
