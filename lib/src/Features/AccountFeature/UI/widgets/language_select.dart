import 'package:Alegny_provider/src/Features/AccountFeature/Bloc/Controller/select_language_controller.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LanguageSelect extends StatelessWidget {
  const LanguageSelect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectLanguageController>(
      init: SelectLanguageController(),
      builder: (controller) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => controller.changeLanguage('ar'),
                child: Row(
                  children: [
                    Radio(
                      value: 'ar',
                      groupValue: controller.selectedLanguage,
                      onChanged: (value) => controller.changeLanguage(value!),
                      activeColor: AppColors.main,
                    ),
                    const CustomTextL('العربية',
                        fontSize: 16, fontWeight: FW.bold),
                  ],
                ),
              ),
              100.ESW(),
              InkWell(
                onTap: () => controller.changeLanguage('en'),
                child: Row(
                  children: [
                    Radio(
                      value: 'en',
                      groupValue: controller.selectedLanguage,
                      onChanged: (value) => controller.changeLanguage(value!),
                      activeColor: AppColors.main,
                    ),
                    const CustomTextL('English',
                        fontSize: 16, fontWeight: FW.bold),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
