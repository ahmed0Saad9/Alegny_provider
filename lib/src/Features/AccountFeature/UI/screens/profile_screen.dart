import 'package:Alegny_provider/src/Features/AccountFeature/Bloc/Controller/profile_controller.dart';
import 'package:Alegny_provider/src/Features/AccountFeature/Bloc/Model/account_details_model.dart';
import 'package:Alegny_provider/src/Features/AccountFeature/UI/screens/reset_password_screen.dart';
import 'package:Alegny_provider/src/Features/AccountFeature/UI/widgets/list_personal_data.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/EditGeneralProfile/Ui/Screen/edit_profile_screen.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/LogOut/Bloc/Controller/log_out_controller.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/services/svg_widget.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

part '../widgets/card_account_details.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) => Container(
        height: Get.height,
        width: Get.width,
        padding: AppPadding.paddingScreenSH36,
        decoration: const BoxDecoration(
          color: AppColors.scaffoldBackGround,
          image: DecorationImage(
            image: AssetImage(
              'assets/images/Gradiant.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            50.ESH(),
            Image.asset(
              'assets/images/logo.png',
              height: 200.h,
              fit: BoxFit.cover,
            ),
            50.ESH(),
            (controller.user != null)
                ? _CardAccountDetails(
                    profile: controller.user!,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      100.ESH(),
                      SpinKitWave(
                        color: AppColors.main,
                      ),
                    ],
                  ),
            const Spacer(),
            const ButtonDefault.main(
              title: 'Remove_Account',
              fw: FW.bold,
              titleColor: AppColors.borderRedF2,
              borderColor: AppColors.borderRedF2,
              buttonColor: AppColors.transparentColor,
            ),
            16.ESH(),
            GetBuilder<LogOutController>(
              init: LogOutController(),
              builder: (controller) => ButtonDefault.main(
                onTap: () => controller.logOut(),
                title: 'Logout',
                fw: FW.bold,
                titleColor: AppColors.titleBlack,
                borderColor: AppColors.borderBlack0B,
                buttonColor: AppColors.transparentColor,
              ),
            ),
            50.ESH(),
          ],
        ),
      ),
    );
  }
}
