import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Bloc/Controller/register_controller.dart';

import 'package:Alegny_provider/src/GeneralWidget/Widgets/StaggeredAnimations/base_column.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/TextFields/text_field_default.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:Alegny_provider/src/core/utils/validator.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      builder: (_) => Container(
        color: AppColors.scaffoldBackGround,
        child: Form(
          key: _.registerGlobalKey,
          child: ListView(
            shrinkWrap: true,
            padding: AppPadding.paddingScreenSH36,
            children: [
              _Body(controller: _),
            ],
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final RegisterController controller;
  const _Body({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    var node = FocusScope.of(context);
    return BaseStaggeredColumn(
      children: [
        100.ESH(),
        const CustomTextL('Join_us_to_start', fontWeight: FW.bold),
        70.ESH(),
        TextFieldDefault(
          label: 'Full_Name',
          controller: controller.nameController,
          validation: nameValidator,
          onComplete: () {
            node.nextFocus();
          },
        ),
        24.ESH(),
        TextFieldDefault(
          label: 'Email',
          controller: controller.emailController,
          validation: emailValidator,
          keyboardType: TextInputType.emailAddress,
          onComplete: () {
            node.nextFocus();
          },
        ),
        24.ESH(),
        TextFieldDefault(
          label: 'Password',
          controller: controller.passwordController,
          validation: passwordValidator,
          secureType: SecureType.toggle,
          onComplete: () {
            node.nextFocus();
          },
        ),
        24.ESH(),
        TextFieldDefault(
          label: 'Confirm_Password',
          controller: controller.confirmPasswordController,
          validation: (value) {
            return confirmPasswordValidator(
                value, controller.passwordController.text);
          },
          secureType: SecureType.toggle,
          onComplete: () {
            node.nextFocus();
          },
        ),
        24.ESH(),
        TextFieldDefault(
          label: 'College_ID',
          controller: controller.idOfCollegeController,
          validation: collegeIdValidator,
          keyboardType: TextInputType.number,
          maxLength: 5,
          onComplete: () {
            node.nextFocus();
          },
        ),
        24.ESH(),
        TextFieldDefault(
          label: 'National_ID',
          controller: controller.nationalIdController,
          validation: nationalIdValidator,
          keyboardType: TextInputType.number,
          maxLength: 14,
          onComplete: () {
            node.unfocus();
            controller.createAccount();
          },
        ),
        120.ESH(),
        ButtonDefault.main(
          onTap: () {
            controller.createAccount();
          },
          title: 'Sign_up',
        ),
        _LoginWidget(
          controller: controller,
        )
      ],
    );
  }
}

class _LoginWidget extends StatelessWidget {
  final RegisterController controller;

  const _LoginWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextL(
          'Have_an_Account',
          fontSize: 14.sp,
          color: AppColors.main,
        ),
        6.ESW(),
        TextButton(
          onPressed: () {
            controller.moveToLogIn();
          },
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          child: CustomTextL(
            decoration: CustomTextDecoration.underLine,
            'login',
            fontSize: 14.sp,
            fontWeight: FW.medium,
            color: AppColors.main,
          ),
        ),
      ],
    );
  }
}
