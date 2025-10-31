import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class DialogOpenAppSetting extends StatelessWidget {
  const DialogOpenAppSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: AppPadding.paddingScreenSH16,
          child: Container(
            padding: AppPadding.paddingScreenSH16SV16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
            ),
            child: Column(
              children: [
                const CustomTextL(
                  "You_should_be_activate_the_location",
                  fontWeight: FW.medium,
                  textAlign: TextAlign.center,
                ),
                const CustomTextL(
                  "Do_You_Want_To_Go_to_App_Setting",
                  fontWeight: FW.bold,
                  color: AppColors.titleGray7A,
                  textAlign: TextAlign.center,
                ),
                16.ESH(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(AppColors.main),
                        ),
                        onPressed: () async {
                          Get.back();
                          await openAppSettings();
                        },
                        child: const CustomTextL(
                          "Ok",
                          fontWeight: FW.medium,
                          fontSize: 14,
                          color: AppColors.titleWhite,
                        )),
                    32.ESW(),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const CustomTextL(
                          "Cancel",
                          fontWeight: FW.medium,
                          fontSize: 14,
                          color: AppColors.titleRedE2,
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
