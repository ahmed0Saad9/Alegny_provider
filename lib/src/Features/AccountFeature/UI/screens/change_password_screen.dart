import 'package:Alegny_provider/src/Features/AccountFeature/Bloc/Controller/change_password_controller.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Appbars/app_bars.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/base_scaffold.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/TextFields/text_field_default.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:Alegny_provider/src/core/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var node = FocusScope.of(context);
    return BaseScaffold(
      appBar: AppBars.appBarBack(title: 'change_password'),
      body: Padding(
        padding: AppPadding.paddingScreenSH16,
        child: GetBuilder<ChangePasswordController>(
          init: ChangePasswordController(),
          builder: (_) => Form(
              key: _.resetPasswordKey,
              child: ListView(
                children: [
                  62.ESH(),
                  Image.asset(
                    'assets/images/Logo.png',
                    width: 90.w,
                    height: 110.h,
                    fit: BoxFit.contain,
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
                        const CustomTextL('change_password'),
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
                          validation: (value) {
                            return confirmPasswordValidator(
                                value, _.newPasswordController.text);
                          },
                          controller: _.confirmPasswordController,
                          secureType: SecureType.toggle,
                        ),
                        24.ESH(),
                        ButtonDefault.main(
                          title: 'change_password',
                          onTap: () => _.changePassword(),
                        ),
                        24.ESH(),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
