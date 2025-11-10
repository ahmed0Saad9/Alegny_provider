import 'dart:async';

import 'package:Alegny_provider/src/core/constants/app_strings.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../constants/color_constants.dart';

class PinCodeServices {
  static pinCodeWidget(
      {Function? onChanged,
      int fieldCounts = 6,
      required BuildContext context,
      required TextEditingController pinCodeController,
      required StreamController<ErrorAnimationType> errorController}) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: PinCodeTextField(
          showCursor: true,
          autoFocus: true,
          autoUnfocus: true,
          autoDismissKeyboard: true,
          enablePinAutofill: true,
          keyboardType: TextInputType.number,
          cursorColor: AppColors.main,
          appContext: context,
          length: fieldCounts,
          obscureText: false,
          pastedTextStyle: TextStyle(
              color: AppColors.main,
              fontSize: 26.sp,
              fontFamily: AppStrings.fontFamily),
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            inactiveColor: AppColors.main,
            inactiveFillColor: AppColors.transparentColor,
            activeColor: AppColors.main,
            disabledColor: Colors.black,
            selectedFillColor: AppColors.transparentColor,
            selectedColor: AppColors.main,
            shape: PinCodeFieldShape.box,
            borderWidth: 1,
            borderRadius: BorderRadius.circular(12.r),
            // fieldHeight: 57.h,
            // fieldWidth: 72.w,
            activeFillColor: AppColors.transparentColor,
          ),
          animationDuration: const Duration(milliseconds: 400),
          backgroundColor: AppColors.transparentColor,
          enableActiveFill: true,
          // errorAnimationController: errorController,
          controller: pinCodeController,
          onCompleted: (v) {
            // debugPrint("Completed");
            // printDM('textEditingController is ${textEditingController.text}');
          },
          onChanged: (value) {
            // onChanged(value);
          },
          beforeTextPaste: (text) {
            // debugPrint("Allowing to paste $text");
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
        ),
      ),
    );
  }
}

class PinCodeWidget extends StatelessWidget {
  final Function? onChanged;
  final int fieldCounts;
  final double fieldWidth;
  final BuildContext context;
  final TextEditingController pinCodeController;
  final StreamController<ErrorAnimationType> errorController;

  const PinCodeWidget(
      {Key? key,
      this.onChanged,
      this.fieldCounts = 6,
      this.fieldWidth = 60.0,
      required this.context,
      required this.pinCodeController,
      required this.errorController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.paddingScreenSH16,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: PinCodeTextField(
          enablePinAutofill: true,
          keyboardType: TextInputType.number,
          cursorColor: AppColors.main,
          appContext: context,
          length: fieldCounts,
          obscureText: false,
          pastedTextStyle: TextStyle(
              color: AppColors.titleGray7A,
              fontSize: 15.sp,
              fontFamily: "bahij-semibold"),
          animationType: AnimationType.scale,
          pinTheme: PinTheme(
            inactiveColor: Colors.transparent,
            inactiveFillColor: Colors.white,
            activeColor: AppColors.main,
            disabledColor: Colors.black,
            selectedFillColor: Colors.white,
            selectedColor: AppColors.main,
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(12.r),
            fieldHeight: 60.h,
            fieldWidth: 60.w,
            activeFillColor: Colors.white,
          ),
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          enableActiveFill: true,
          errorAnimationController: errorController,
          controller: pinCodeController,
          onCompleted: (v) {
            // debugPrint("Completed");
            // printDM('textEditingController is ${textEditingController.text}');
          },
          onChanged: (value) {
            // onChanged(value);
          },
          beforeTextPaste: (text) {
            // debugPrint("Allowing to paste $text");
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
        ),
      ),
    );
  }
}
