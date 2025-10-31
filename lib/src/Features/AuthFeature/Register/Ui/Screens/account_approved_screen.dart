import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/LogIn/Ui/Screens/login_screen.dart';
import 'package:Alegny_provider/src/Features/BaseBNBFeature/UI/screens/base_BNB_screen.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/base_scaffold.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class AccountApprovedScreen extends StatelessWidget {
  const AccountApprovedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: Padding(
      padding: AppPadding.paddingScreenSH36,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/AccountApproved.png',
              width: 283.w,
              height: 180.h,
            ),
            45.ESH(),
            const CustomTextL(
              'Account_Approved',
              textAlign: TextAlign.center,
              fontWeight: FW.bold,
              fontSize: 25,
            ),
            9.ESH(),
            CustomTextL.subtitle(
              'Now_you_can_use_the_app_freely',
              textAlign: TextAlign.center,
              fontSize: 16,
            ),
            90.ESH(),
            ButtonDefault.main(
              onTap: () => Get.offAll(() => const BaseBNBScreen()),
              title: 'GO',
              fw: FW.regular,
              // width: 200.w,
            ),
          ],
        ),
      ),
    ));
  }
}
