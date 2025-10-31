import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/StaggeredAnimations/base_column.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/TextFields/text_field_default.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:Alegny_provider/src/core/utils/validator.dart';

class ChangePasswordBody extends StatelessWidget {
  const ChangePasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    var node = FocusScope.of(context);
    return Expanded(
      child: Container(
        color: AppColors.backGroundGreyFD,
        padding: AppPadding.paddingScreenSH16,
        child: BaseStaggeredColumn(children: [
          TextFieldDefault(
            hint: 'old_Password',
            prefixIconUrl: 'password',
            // controller: controller.passwordController,
            validation: passwordValidator,
            secureType: SecureType.always,
            keyboardType: TextInputType.text,
            onComplete: () {
              node.nextFocus();
            },
          ),
          14.ESH(),
          TextFieldDefault(
            hint: 'new_Password',
            prefixIconUrl: 'password',
            // controller: controller.passwordController,
            validation: passwordValidator,
            secureType: SecureType.always,
            keyboardType: TextInputType.text,
            onComplete: () {
              node.nextFocus();
            },
          ),
          14.ESH(),
          TextFieldDefault(
            hint: 'Confirm_new_password',
            prefixIconUrl: 'password',
            // controller: controller.confirmPasswordController,
            // validation: (value) {
            //   return confirmPasswordValidator(
            //       value, controller.passwordController.text);
            // },
            secureType: SecureType.always,
            keyboardType: TextInputType.text,
            onComplete: () {
              node.nextFocus();
            },
          ),
        ]),
      ),
    );
  }
}
