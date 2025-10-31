import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:Alegny_provider/src/Features/BaseBNBFeature/Bloc/Controller/base_BNB_controller.dart';
import 'package:Alegny_provider/src/Features/BaseBNBFeature/UI/screens/base_BNB_screen.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class DialogDone extends StatelessWidget {
  const DialogDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
            height: 150,
            child: Lottie.asset(
              'assets/lottie/DoneAnimation.json', // Add your Lottie file
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 20),
          const CustomTextL(
            'Upload_Complete',
            color: AppColors.main,
            fontWeight: FW.bold,
          ),
          10.ESH(),
          CustomTextL(
            'Upload_is_done_waiting_for_the_admin_to_approve',
            textAlign: TextAlign.center,
            color: Colors.green[900],
          ),
          20.ESH(),
          GetBuilder<BaseNBNController>(
            builder: (controller) => ButtonDefault.main(
                title: 'ok',
                onTap: () {
                  Get.back();
                  controller.updateIndex(2);
                }),
          ),
        ]),
      ),
    );
  }
}
