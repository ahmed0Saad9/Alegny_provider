import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';

void customSnackBar(
    {bool isError = false,
    String title = '',
    String subtitle = '',
    void Function(SnackbarStatus?)? snackBarStatus}) {
  Get.snackbar(
    '',
    '',
    backgroundColor: isError ? AppColors.errorSnackBar : AppColors.doneSnackBar,
    snackPosition: SnackPosition.TOP,
    margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
    titleText: CustomTextL(
      title.tr,
      color: Colors.white,
      fontWeight: FW.bold,
      fontSize: 15,
    ),
    messageText: CustomTextL(
      subtitle,
      color: Colors.white,
      fontWeight: FW.medium,
      fontSize: 12,
    ),
    // icon: Icon(Icons.edit_notifications_outlined,color: Colors.white,),
    snackbarStatus: snackBarStatus,
  );
}
