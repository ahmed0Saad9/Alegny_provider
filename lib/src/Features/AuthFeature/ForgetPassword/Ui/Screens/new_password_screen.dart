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
  final String token;
  final String email;
  final String code;

  const NewPasswordScreen({
    super.key,
    required this.token,
    required this.email,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    var node = FocusScope.of(context);
    return BaseScaffold(
      appBar: AppBars.appBarBack(title: 'change_password'),
      body: GetBuilder<ForgetPasswordController>(
        builder: (_) => Form(
          key: _.resetPasswordGlobalKey,
          child: Padding(
            padding: AppPadding.paddingScreenSH16,
            child: ListView(
              children: [
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
                  label: 'New_Password'.tr,
                  controller: _.newPasswordController,
                  validation: passwordValidator,
                  secureType: SecureType.toggle,
                  onComplete: () {
                    node.nextFocus();
                  },
                ),
                24.ESH(),
                TextFieldDefault(
                  label: 'Re_Enter_Password'.tr,
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
                350.ESH(),
                ButtonDefault.main(
                  title: 'Continue',
                  onTap: () {
                    _.resetPassword(
                      token: token,
                      email: email,
                      code: code,
                    );
                  },
                ),
                33.ESH(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
