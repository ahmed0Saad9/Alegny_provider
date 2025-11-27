import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/LogIn/Bloc/Controller/login_controller.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/StaggeredAnimations/base_column.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/TextFields/text_field_default.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/utils/validator.dart';
import 'package:lottie/lottie.dart';

import '../../../../../GeneralWidget/Widgets/Other/base_scaffold.dart';
import '/src/core/utils/extensions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var node = FocusScope.of(context);
    return BaseScaffold(
      body: GetBuilder<LoginController>(
        init: LoginController(),
        builder: (_) => Form(
          key: _.loginGlobalKey,
          child: Padding(
            padding: AppPadding.paddingScreenSH16,
            child: ListView(
              shrinkWrap: true,
              children: [
                BaseStaggeredColumn(
                  children: [
                    20.ESH(),
                    Row(
                      children: [
                        const CustomTextL('welcome_back', fontWeight: FW.bold),
                        SizedBox(
                          height: 40.h,
                          child: Lottie.asset(
                            'assets/lottie/HandWave.json',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    50.ESH(),
                    TextFieldDefault(
                      label: 'Email',
                      prefixIconUrl: 'Email',
                      autoFillHints: const [
                        // AutofillHints.username,
                        AutofillHints.email
                      ],
                      controller: _.emailController,
                      validation: emailValidator,
                      keyboardType: TextInputType.emailAddress,
                      onComplete: () {
                        node.nextFocus();
                      },
                    ),
                    24.ESH(),
                    TextFieldDefault(
                      label: 'Password',
                      prefixIconUrl: 'Lock',
                      autoFillHints: const [AutofillHints.password],
                      controller: _.passwordController,
                      validation: passwordValidator,
                      secureType: SecureType.toggle,
                      onComplete: () {
                        node.unfocus();
                        _.logIn();
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(() => Checkbox(
                              value: _.rememberMe.value,
                              onChanged: (v) => _.rememberMe.value = v!,
                            )),
                        CustomTextL(
                          'Remember_me',
                          fontSize: 16.sp,
                        ),
                        const Spacer(),
                        ButtonForgetPassword(controller: _),
                      ],
                    ),
                    410.ESH(),
                    ButtonDefault.main(
                      onTap: () => _.logIn(),
                      title: 'login',
                    ),
                    _DoNotHaveAccountWidget(
                      controller: _,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DoNotHaveAccountWidget extends StatelessWidget {
  final LoginController controller;
  const _DoNotHaveAccountWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextL(
          'dont_have_account_register',
          fontSize: 16.sp,
          color: AppColors.titleMain,
        ),
        TextButton(
          onPressed: () {
            controller.moveToRegister();
          },
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          child: CustomTextL(
            decoration: CustomTextDecoration.underLine,
            'join_us',
            fontSize: 16.sp,
            fontWeight: FW.medium,
            color: AppColors.main,
          ),
        ),
      ],
    );
  }
}

class ButtonForgetPassword extends StatelessWidget {
  final LoginController controller;
  const ButtonForgetPassword({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              controller.moveToForgetPassword();
            },
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: CustomTextL(
              'Forget_password',
              fontSize: 16.sp,
              fontWeight: FW.medium,
              color: AppColors.main,
            )),
      ],
    );
  }
}
