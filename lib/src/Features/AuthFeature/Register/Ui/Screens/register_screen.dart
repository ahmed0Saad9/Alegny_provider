import 'package:Alegny_provider/src/Features/AuthFeature/Register/Ui/Screens/terms_and_conditions_screen.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/TextFields/text_field_phone.dart';
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
import 'package:lottie/lottie.dart';

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
            padding: AppPadding.paddingScreenSH16,
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
        80.ESH(),
        Row(
          children: [
            const CustomTextL('Join_us_to_start', fontWeight: FW.bold),
            Lottie.asset(
              'assets/lottie/CreateAccount.json',
              height: 60.h,
              fit: BoxFit.contain,
            ),
          ],
        ),
        Row(
          children: [
            CustomTextL.subtitle(
              'Create_your_account_for_a_better_experience',
              fontWeight: FW.medium,
            ),
          ],
        ),
        50.ESH(),
        Row(
          children: [
            Expanded(
              child: TextFieldDefault(
                label: 'First_Name',
                prefixIconUrl: 'Profile',
                controller: controller.firstNameController,
                validation: nameValidator,
                onComplete: () {
                  node.nextFocus();
                },
              ),
            ),
            10.ESW(),
            Expanded(
              child: TextFieldDefault(
                label: 'Family_Name',
                prefixIconUrl: 'Profile',
                controller: controller.familyNameController,
                validation: nameValidator,
                onComplete: () {
                  node.nextFocus();
                },
              ),
            ),
          ],
        ),
        24.ESH(),
        TextFieldDefault(
          label: 'Email',
          prefixIconUrl: 'Email',
          controller: controller.emailController,
          validation: emailValidator,
          keyboardType: TextInputType.emailAddress,
          onComplete: () {
            node.nextFocus();
          },
        ),
        24.ESH(),
        TextFieldPhone(
          node: node,
          controller: controller.phoneController,
          onCountryChanged: (p0) {},
          initialCountryCode: '+20',
        ),
        10.ESH(),
        TextFieldDefault(
          label: 'Password',
          prefixIconUrl: 'Lock',
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
          prefixIconUrl: 'Lock',
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
        _AcceptTermsAndConditions(controller: controller),
        100.ESH(),
        ButtonDefault.main(
          onTap: () {
            // controller.createAccount();
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

class _AcceptTermsAndConditions extends StatelessWidget {
  const _AcceptTermsAndConditions({
    super.key,
    required this.controller,
  });

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: controller.acceptTermsAndConditions,
          onChanged: (value) => controller.toggleAcceptTermsAndConditions(),
          activeColor: AppColors.main,
        ),
        CustomTextL(
          'I_agree_on',
          fontSize: 14.sp,
          fontWeight: FW.medium,
        ),
        TextButton(
            onPressed: () => Get.to(() => const TermsConditionsScreen()),
            child: CustomTextL(
              'Terms_and_conditions',
              color: AppColors.main,
              fontSize: 14.sp,
              fontWeight: FW.bold,
              decoration: CustomTextDecoration.underLine,
            ))
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
          color: AppColors.titleMain,
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
            fontWeight: FW.bold,
            color: AppColors.main,
          ),
        ),
      ],
    );
  }
}
