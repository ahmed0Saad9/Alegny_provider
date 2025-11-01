import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
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

  static const List<Country> arabicCountries = [
    // North Africa
    Country(
      name: "Egypt",
      nameTranslations: {
        "en": "Egypt",
        "ar": "مصر",
      },
      flag: "🇪🇬",
      code: "EG",
      dialCode: "20",
      minLength: 10,
      maxLength: 10,
    ),
    Country(
      name: "Libya",
      nameTranslations: {
        "en": "Libya",
        "ar": "ليبيا",
      },
      flag: "🇱🇾",
      code: "LY",
      dialCode: "218",
      minLength: 9,
      maxLength: 10,
    ),
    Country(
      name: "Tunisia",
      nameTranslations: {
        "en": "Tunisia",
        "ar": "تونس",
      },
      flag: "🇹🇳",
      code: "TN",
      dialCode: "216",
      minLength: 8,
      maxLength: 8,
    ),
    Country(
      name: "Algeria",
      nameTranslations: {
        "en": "Algeria",
        "ar": "الجزائر",
      },
      flag: "🇩🇿",
      code: "DZ",
      dialCode: "213",
      minLength: 9,
      maxLength: 9,
    ),
    Country(
      name: "Morocco",
      nameTranslations: {
        "en": "Morocco",
        "ar": "المغرب",
      },
      flag: "🇲🇦",
      code: "MA",
      dialCode: "212",
      minLength: 9,
      maxLength: 9,
    ),
    Country(
      name: "Mauritania",
      nameTranslations: {
        "en": "Mauritania",
        "ar": "موريتانيا",
      },
      flag: "🇲🇷",
      code: "MR",
      dialCode: "222",
      minLength: 8,
      maxLength: 8,
    ),
    Country(
      name: "Sudan",
      nameTranslations: {
        "en": "Sudan",
        "ar": "السودان",
      },
      flag: "🇸🇩",
      code: "SD",
      dialCode: "249",
      minLength: 9,
      maxLength: 9,
    ),

    // Arabian Peninsula
    Country(
      name: "Saudi Arabia",
      nameTranslations: {
        "en": "Saudi Arabia",
        "ar": "السعودية",
      },
      flag: "🇸🇦",
      code: "SA",
      dialCode: "966",
      minLength: 9,
      maxLength: 9,
    ),
    Country(
      name: "United Arab Emirates",
      nameTranslations: {
        "en": "United Arab Emirates",
        "ar": "الإمارات العربية المتحدة",
      },
      flag: "🇦🇪",
      code: "AE",
      dialCode: "971",
      minLength: 9,
      maxLength: 9,
    ),
    Country(
      name: "Kuwait",
      nameTranslations: {
        "en": "Kuwait",
        "ar": "الكويت",
      },
      flag: "🇰🇼",
      code: "KW",
      dialCode: "965",
      minLength: 8,
      maxLength: 8,
    ),
    Country(
      name: "Qatar",
      nameTranslations: {
        "en": "Qatar",
        "ar": "قطر",
      },
      flag: "🇶🇦",
      code: "QA",
      dialCode: "974",
      minLength: 8,
      maxLength: 8,
    ),
    Country(
      name: "Bahrain",
      nameTranslations: {
        "en": "Bahrain",
        "ar": "البحرين",
      },
      flag: "🇧🇭",
      code: "BH",
      dialCode: "973",
      minLength: 8,
      maxLength: 8,
    ),
    Country(
      name: "Oman",
      nameTranslations: {
        "en": "Oman",
        "ar": "عمان",
      },
      flag: "🇴🇲",
      code: "OM",
      dialCode: "968",
      minLength: 8,
      maxLength: 8,
    ),
    Country(
      name: "Yemen",
      nameTranslations: {
        "en": "Yemen",
        "ar": "اليمن",
      },
      flag: "🇾🇪",
      code: "YE",
      dialCode: "967",
      minLength: 9,
      maxLength: 9,
    ),

    // Levant
    Country(
      name: "Jordan",
      nameTranslations: {
        "en": "Jordan",
        "ar": "الأردن",
      },
      flag: "🇯🇴",
      code: "JO",
      dialCode: "962",
      minLength: 9,
      maxLength: 9,
    ),
    Country(
      name: "Palestine",
      nameTranslations: {
        "en": "Palestine",
        "ar": "فلسطين",
      },
      flag: "🇵🇸",
      code: "PS",
      dialCode: "970",
      minLength: 9,
      maxLength: 9,
    ),
    Country(
      name: "Lebanon",
      nameTranslations: {
        "en": "Lebanon",
        "ar": "لبنان",
      },
      flag: "🇱🇧",
      code: "LB",
      dialCode: "961",
      minLength: 8,
      maxLength: 8,
    ),
    Country(
      name: "Syria",
      nameTranslations: {
        "en": "Syria",
        "ar": "سوريا",
      },
      flag: "🇸🇾",
      code: "SY",
      dialCode: "963",
      minLength: 9,
      maxLength: 9,
    ),

    // Mesopotamia
    Country(
      name: "Iraq",
      nameTranslations: {
        "en": "Iraq",
        "ar": "العراق",
      },
      flag: "🇮🇶",
      code: "IQ",
      dialCode: "964",
      minLength: 10,
      maxLength: 10,
    ),

    // East Africa (Arab League members)
    Country(
      name: "Somalia",
      nameTranslations: {
        "en": "Somalia",
        "ar": "الصومال",
      },
      flag: "🇸🇴",
      code: "SO",
      dialCode: "252",
      minLength: 8,
      maxLength: 9,
    ),
    Country(
      name: "Djibouti",
      nameTranslations: {
        "en": "Djibouti",
        "ar": "جيبوتي",
      },
      flag: "🇩🇯",
      code: "DJ",
      dialCode: "253",
      minLength: 8,
      maxLength: 8,
    ),
    Country(
      name: "Comoros",
      nameTranslations: {
        "en": "Comoros",
        "ar": "جزر القمر",
      },
      flag: "🇰🇲",
      code: "KM",
      dialCode: "269",
      minLength: 7,
      maxLength: 7,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return Directionality(
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      child: IntlPhoneField(
        showCountryFlag: true,
        countries: arabicCountries,
        disableLengthCheck: false,
        flagsButtonPadding: EdgeInsets.symmetric(horizontal: 8.w),
        dropdownIconPosition: IconPosition.trailing,
        pickerDialogStyle: PickerDialogStyle(
          searchFieldInputDecoration: InputDecoration(
            labelText: 'Search_country'.tr,
            suffixIcon: const Icon(Icons.search),
            border: const OutlineInputBorder(),
          ),
        ),
        dropdownTextStyle: TextStyle(
          fontSize: 14.sp,
          color: Colors.black87,
          fontFamily: "Regular",
        ),
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.black87,
          fontFamily: "Regular",
        ),
        dropdownIcon: Icon(
          Icons.arrow_drop_down,
          color: TextFieldColors.enableBorder,
          size: 24.sp,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: TextFieldColors.enableBorder,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          contentPadding: EdgeInsets.only(
            left: isRTL ? 16.w : 16.w,
            right:
                isRTL ? 110.w : 60.w, // More space in RTL for country selector
            top: 16.h,
            bottom: 16.h,
          ),
          enabled: true,
          filled: true,
          fillColor: TextFieldColors.backGroundWhite,
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: IconSvg(
              'Phone',
              width: 20.w,
              height: 20.h,
              size: 20,
              color: TextFieldColors.icon,
            ),
          ),
          suffixIconConstraints: BoxConstraints(
            minWidth: 48.w,
            minHeight: 48.h,
          ),
          hintText: 'Phone_number'.tr,
          hintStyle: TextStyle(
            fontSize: 16.sp,
            color: TextFieldColors.hintTitle,
            fontFamily: "Medium",
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.main,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: TextFieldColors.enableBorder,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red.shade400,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red.shade400,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        languageCode: isRTL ? 'ar' : 'en',
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
        invalidNumberMessage: isRTL ? 'رقم غير صالح' : 'Invalid number',
      ),
    );
  }
}
