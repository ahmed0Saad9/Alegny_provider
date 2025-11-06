import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';

void showToast(String msg, {bool isError = false}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: isError ? AppColors.errorSnackBar : AppColors.doneSnackBar,
    textColor: AppColors.titleWhite,
    fontSize: 16.0,
  );
}

void showSnackBar(String msg, {bool isError = false}) {
  Get.snackbar(
    msg,
    '',
    // padding: EdgeInsets.zero,
    // backgroundColor:
    //     isError ? AppColors.errorSnackBar : AppColors.backGroundGrey,
    borderRadius: 16.r,
    icon: Icon(
      isError ? Icons.error_outline : Icons.check,
      color: isError ? AppColors.errorSnackBar : AppColors.iconGray,
    ),
    snackPosition: SnackPosition.BOTTOM,
  );
}
