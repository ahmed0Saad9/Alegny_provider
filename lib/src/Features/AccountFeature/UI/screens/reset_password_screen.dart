import 'package:Alegny_provider/src/Features/AccountFeature/Bloc/Controller/reset_password_controller.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/ForgetPassword/Bloc/Controller/forget_password_controller.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Appbars/app_bars.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/base_scaffold.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/TextFields/text_field_default.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:Alegny_provider/src/core/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

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
      child: BaseScaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBars.appBarBack(),
        body: Padding(
          padding: AppPadding.paddingScreenSH36,
          child: GetBuilder<ResetPasswordController>(
            init: ResetPasswordController(),
            builder: (_) => Form(
                key: _.resetPasswordKey,
                child: ListView(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 148.w,
                      height: 181.h,
                    ),
                    62.ESH(),
                    Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: AppPadding.paddingScreenSH16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          24.ESH(),
                          const CustomTextL('Reset_Password'),
                          18.ESH(),
                          TextFieldDefault(
                            label: "Current_Password",
                            validation: passwordValidator,
                            controller: _.currentPasswordController,
                            secureType: SecureType.toggle,
                          ),
                          24.ESH(),
                          TextFieldDefault(
                            label: "New_Password",
                            validation: passwordValidator,
                            controller: _.newPasswordController,
                            secureType: SecureType.toggle,
                          ),
                          24.ESH(),
                          TextFieldDefault(
                            label: "Confirm_New_Password",
                            validation: passwordValidator,
                            controller: _.confirmPasswordController,
                            secureType: SecureType.toggle,
                          ),
                          24.ESH(),
                        ],
                      ),
                    ),
                    // Spacer(),
                    170.ESH(),
                    ButtonDefault.main(
                      title: 'change_password',
                      active: _.currentPasswordController.text.isNotEmpty &&
                          _.newPasswordController.text.isNotEmpty &&
                          _.confirmPasswordController.text.isNotEmpty,
                      onTap: () => _.resetPassword(),
                    ),
                    24.ESH(),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
