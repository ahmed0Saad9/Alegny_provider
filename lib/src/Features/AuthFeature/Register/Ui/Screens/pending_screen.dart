import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/LogIn/Ui/Screens/login_screen.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Bloc/Controller/register_controller.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/base_scaffold.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class PendingScreen extends StatelessWidget {
  const PendingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      builder: (controller) => Padding(
        padding: AppPadding.paddingScreenSH36,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            150.ESH(),
            Image.asset(
              'assets/images/PendingImage.png',
              width: 283.w,
              height: 180.h,
            ),
            45.ESH(),
            const CustomTextL(
              'Sign_up_successful',
              textAlign: TextAlign.center,
              fontWeight: FW.bold,
              fontSize: 25,
            ),
            9.ESH(),
            CustomTextL.subtitle(
              'Please_wait_for_admin_to_approve_your_account',
              textAlign: TextAlign.center,
              fontSize: 16,
            ),
            40.ESH(),
            Row(
              children: [
                Container(
                  color: AppColors.dividerBlack,
                  height: 1.h,
                  width: 130.w,
                ),
                Spacer(),
                const CustomTextL(
                  'OR',
                  textAlign: TextAlign.center,
                  fontWeight: FW.bold,
                  fontSize: 25,
                ),
                Spacer(),
                Container(
                  color: AppColors.dividerBlack,
                  height: 1.h,
                  width: 130.w,
                ),
              ],
            ),
            30.ESH(),
            ButtonDefault.main(
              onTap: () => Get.off(() => const LoginScreen()),
              title: 'login',
              fw: FW.regular,
              // width: 200.w,
            ),
          ],
        ),
      ),
    );
  }
}
