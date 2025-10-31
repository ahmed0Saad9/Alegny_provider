import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:Alegny_provider/src/core/constants/app_assets.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/services/svg_widget.dart';

class TextFieldPhone extends StatelessWidget {
  const TextFieldPhone({
    super.key,
    required this.node,
    required this.controller,
    required this.onCountryChanged,
    required this.initialCountryCode,
  });

  final Function(Country) onCountryChanged;
  final FocusScopeNode node;
  final TextEditingController controller;
  final String initialCountryCode;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      showCountryFlag: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.transparentColor,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        contentPadding: AppPadding.paddingScreenSH8,
        enabled: true,
        filled: true,
        fillColor: TextFieldColors.usedBackGround,
        suffixIcon: IconSvg(
          'call',
          width: 20.w,
          height: 20.h,
          size: 20,
        ),
        hintText: 'رقم الهاتف',
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: TextFieldColors.hintTitle,
          fontFamily: "Regular",
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.transparentColor,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.transparentColor,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      controller: controller,
      onSubmitted: (v) {
        node.nextFocus();
        printDM('controller is => ${controller.text}');
      },
      onChanged: (phone) {
        printDM(phone.completeNumber);
      },
      initialCountryCode: initialCountryCode,
      keyboardType: TextInputType.phone,
      onCountryChanged: onCountryChanged,
    );
  }
}
