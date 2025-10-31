import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

class PasswordUpdateFailedDialog extends StatelessWidget {
  const PasswordUpdateFailedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 150,
              child: Lottie.asset(
                'assets/lottie/FailAnimation.json',
                fit: BoxFit.contain,
              ),
            ),
            10.ESH(),
            CustomTextL(
              'Could_not_change_password',
              fontSize: 20.sp,
              fontWeight: FW.bold,
              color: Colors.red,
            ),
            20.ESH(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonDefault(
                  title: 'TRY_AGAIN',
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
