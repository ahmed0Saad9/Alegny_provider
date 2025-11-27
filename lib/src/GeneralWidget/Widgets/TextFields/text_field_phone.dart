import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:Alegny_provider/src/core/constants/app_assets.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/services/svg_widget.dart';

class TextFieldPhone extends StatefulWidget {
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
  State<TextFieldPhone> createState() => _TextFieldPhoneState();
}

class _TextFieldPhoneState extends State<TextFieldPhone> {
  Country? _selectedCountry;
  String? _validationError;

  static const List<Country> arabicCountries = [
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

  // Country-specific validation rules
  final Map<String, PhoneValidationRule> _validationRules = {
    'EG': PhoneValidationRule(
      // Egypt
      pattern: RegExp(r'^1[0-2,5][0-9]{8}$'),
      example: '10XXXXXXXX',
      message: {
        'en': 'Egyptian numbers must start with 10, 11, 12, or 15',
        'ar': 'يجب أن تبدأ الأرقام المصرية بـ 10، 11، 12، أو 15',
      },
    ),
    'SA': PhoneValidationRule(
      // Saudi Arabia
      pattern: RegExp(r'^5[0-9]{8}$'),
      example: '5XXXXXXXX',
      message: {
        'en': 'Saudi numbers must start with 5',
        'ar': 'يجب أن تبدأ الأرقام السعودية بالرقم 5',
      },
    ),
    'AE': PhoneValidationRule(
      // UAE
      pattern: RegExp(r'^5[0-9]{8}$'),
      example: '5XXXXXXXX',
      message: {
        'en': 'UAE numbers must start with 5',
        'ar': 'يجب أن تبدأ أرقام الإمارات بالرقم 5',
      },
    ),
    'KW': PhoneValidationRule(
      // Kuwait
      pattern: RegExp(r'^[569][0-9]{7}$'),
      example: '5XXXXXXX',
      message: {
        'en': 'Kuwaiti numbers must start with 5, 6, or 9',
        'ar': 'يجب أن تبدأ الأرقام الكويتية بالرقم 5 أو 6 أو 9',
      },
    ),
    'QA': PhoneValidationRule(
      // Qatar
      pattern: RegExp(r'^[3-7][0-9]{7}$'),
      example: '3XXXXXXX',
      message: {
        'en': 'Qatari numbers must start with 3, 4, 5, 6, or 7',
        'ar': 'يجب أن تبدأ الأرقام القطرية بالأرقام من 3 إلى 7',
      },
    ),
    'BH': PhoneValidationRule(
      // Bahrain
      pattern: RegExp(r'^3[0-9]{7}$'),
      example: '3XXXXXXX',
      message: {
        'en': 'Bahraini numbers must start with 3',
        'ar': 'يجب أن تبدأ الأرقام البحرينية بالرقم 3',
      },
    ),
    'OM': PhoneValidationRule(
      // Oman
      pattern: RegExp(r'^[79][0-9]{7}$'),
      example: '7XXXXXXX',
      message: {
        'en': 'Omani numbers must start with 7 or 9',
        'ar': 'يجب أن تبدأ الأرقام العمانية بالرقم 7 أو 9',
      },
    ),
    'YE': PhoneValidationRule(
      // Yemen
      pattern: RegExp(r'^7[0-9]{8}$'),
      example: '7XXXXXXXX',
      message: {
        'en': 'Yemeni numbers must start with 7',
        'ar': 'يجب أن تبدأ الأرقام اليمنية بالرقم 7',
      },
    ),
    'JO': PhoneValidationRule(
      // Jordan
      pattern: RegExp(r'^7[0-9]{8}$'),
      example: '7XXXXXXXX',
      message: {
        'en': 'Jordanian numbers must start with 7',
        'ar': 'يجب أن تبدأ الأرقام الأردنية بالرقم 7',
      },
    ),
    'PS': PhoneValidationRule(
      // Palestine
      pattern: RegExp(r'^5[0-9]{8}$'),
      example: '5XXXXXXXX',
      message: {
        'en': 'Palestinian numbers must start with 5',
        'ar': 'يجب أن تبدأ الأرقام الفلسطينية بالرقم 5',
      },
    ),
    'LB': PhoneValidationRule(
      // Lebanon
      pattern: RegExp(r'^[3,7][0-9]{7}$'),
      example: '3XXXXXXX',
      message: {
        'en': 'Lebanese numbers must start with 3 or 7',
        'ar': 'يجب أن تبدأ الأرقام اللبنانية بالرقم 3 أو 7',
      },
    ),
    'SY': PhoneValidationRule(
      // Syria
      pattern: RegExp(r'^9[0-9]{8}$'),
      example: '9XXXXXXXX',
      message: {
        'en': 'Syrian numbers must start with 9',
        'ar': 'يجب أن تبدأ الأرقام السورية بالرقم 9',
      },
    ),
    'IQ': PhoneValidationRule(
      // Iraq
      pattern: RegExp(r'^7[0-9]{9}$'),
      example: '7XXXXXXXXX',
      message: {
        'en': 'Iraqi numbers must start with 7',
        'ar': 'يجب أن تبدأ الأرقام العراقية بالرقم 7',
      },
    ),
    'DZ': PhoneValidationRule(
      // Algeria
      pattern: RegExp(r'^[5-7][0-9]{8}$'),
      example: '5XXXXXXXX',
      message: {
        'en': 'Algerian numbers must start with 5, 6, or 7',
        'ar': 'يجب أن تبدأ الأرقام الجزائرية بالرقم 5 أو 6 أو 7',
      },
    ),
    'MA': PhoneValidationRule(
      // Morocco
      pattern: RegExp(r'^[6-7][0-9]{8}$'),
      example: '6XXXXXXXX',
      message: {
        'en': 'Moroccan numbers must start with 6 or 7',
        'ar': 'يجب أن تبدأ الأرقام المغربية بالرقم 6 أو 7',
      },
    ),
    'TN': PhoneValidationRule(
      // Tunisia
      pattern: RegExp(r'^[2,5,9][0-9]{7}$'),
      example: '2XXXXXXX',
      message: {
        'en': 'Tunisian numbers must start with 2, 5, or 9',
        'ar': 'يجب أن تبدأ الأرقام التونسية بالرقم 2 أو 5 أو 9',
      },
    ),
    'LY': PhoneValidationRule(
      // Libya
      pattern: RegExp(r'^9[0-9]{8}$'),
      example: '9XXXXXXXX',
      message: {
        'en': 'Libyan numbers must start with 9',
        'ar': 'يجب أن تبدأ الأرقام الليبية بالرقم 9',
      },
    ),
    'SD': PhoneValidationRule(
      // Sudan
      pattern: RegExp(r'^9[0-9]{8}$'),
      example: '9XXXXXXXX',
      message: {
        'en': 'Sudanese numbers must start with 9',
        'ar': 'يجب أن تبدأ الأرقام السودانية بالرقم 9',
      },
    ),
    'SO': PhoneValidationRule(
      // Somalia
      pattern: RegExp(r'^[6-9][0-9]{7,8}$'),
      example: '6XXXXXXX',
      message: {
        'en': 'Somali numbers must start with 6, 7, 8, or 9',
        'ar': 'يجب أن تبدأ الأرقام الصومالية بالرقم 6 أو 7 أو 8 أو 9',
      },
    ),
    'MR': PhoneValidationRule(
      // Mauritania
      pattern: RegExp(r'^[2-4][0-9]{7}$'),
      example: '2XXXXXXX',
      message: {
        'en': 'Mauritanian numbers must start with 2, 3, or 4',
        'ar': 'يجب أن تبدأ الأرقام الموريتانية بالرقم 2 أو 3 أو 4',
      },
    ),
    'DJ': PhoneValidationRule(
      // Djibouti
      pattern: RegExp(r'^[7-8][0-9]{7}$'),
      example: '7XXXXXXX',
      message: {
        'en': 'Djiboutian numbers must start with 7 or 8',
        'ar': 'يجب أن تبدأ الأرقام الجيبوتية بالرقم 7 أو 8',
      },
    ),
    'KM': PhoneValidationRule(
      // Comoros
      pattern: RegExp(r'^[3,8][0-9]{6}$'),
      example: '3XXXXXX',
      message: {
        'en': 'Comorian numbers must start with 3 or 8',
        'ar': 'يجب أن تبدأ أرقام جزر القمر بالرقم 3 أو 8',
      },
    ),
  };

  String? _validatePhone(PhoneNumber? phoneNumber) {
    if (phoneNumber == null || phoneNumber.number.isEmpty) {
      return 'Phone_number_required'.tr;
    }

    // Get the phone number without the country code
    final number = phoneNumber.number;

    // Check if we have a selected country
    if (_selectedCountry == null) {
      return 'Please_select_country'.tr;
    }

    // Check length
    if (number.length < _selectedCountry!.minLength) {
      return 'Phone_number_too_short'.tr;
    }

    if (number.length > _selectedCountry!.maxLength) {
      return 'Phone_number_too_long'.tr;
    }

    // Country-specific validation
    final countryCode = _selectedCountry!.code;
    if (_validationRules.containsKey(countryCode)) {
      final rule = _validationRules[countryCode]!;
      if (!rule.pattern.hasMatch(number)) {
        final bool isRTL = Directionality.of(context) == TextDirection.rtl;
        final language = isRTL ? 'ar' : 'en';
        return rule.message[language] ?? 'Invalid_phone_format'.tr;
      }
    }

    // General validation for other countries
    if (!RegExp(r'^[0-9]+$').hasMatch(number)) {
      return 'Phone_number_contains_invalid_characters'.tr;
    }

    return null;
  }

  void _handleCountryChanged(Country country) {
    setState(() {
      _selectedCountry = country;
      // Trigger validation with current phone number
      final currentNumber = PhoneNumber(
        countryCode: country.code,
        countryISOCode: country.code,
        number: widget.controller.text,
      );
      _validationError = _validatePhone(currentNumber);
    });
    widget.onCountryChanged(country);
  }

  void _handlePhoneChanged(PhoneNumber? phone) {
    if (phone != null) {
      final validationResult = _validatePhone(phone);
      setState(() {
        _validationError = validationResult;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Find initial country
    _selectedCountry = arabicCountries.firstWhere(
      (country) => country.code == widget.initialCountryCode,
      orElse: () => arabicCountries.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Directionality(
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          child: IntlPhoneField(
            showCountryFlag: true,
            countries: arabicCountries,
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
                borderSide: const BorderSide(
                  color: TextFieldColors.enableBorder,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              contentPadding: EdgeInsets.only(
                left: isRTL ? 16.w : 16.w,
                right: isRTL ? 110.w : 60.w,
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
                borderSide: const BorderSide(
                  color: AppColors.main,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
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
              errorMaxLines: 2,
            ),
            languageCode: isRTL ? 'ar' : 'en',
            controller: widget.controller,
            onSubmitted: (v) {
              widget.node.nextFocus();
              printDM('controller is => ${widget.controller.text}');
            },
            onChanged: _handlePhoneChanged,
            initialCountryCode: widget.initialCountryCode,
            keyboardType: TextInputType.phone,
            onCountryChanged: _handleCountryChanged,
            invalidNumberMessage: '', // Empty to override default messages

            // Validation - FIXED: Now accepts PhoneNumber? parameter
            validator: _validatePhone,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),

        // Display validation error message if any
        if (_validationError != null && _validationError!.isNotEmpty) ...[
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: CustomTextL(
              _validationError!,
              fontSize: 12.sp,
              color: Colors.red.shade600,
              fontWeight: FW.medium,
            ),
          ),
        ],

        // Display country-specific hint if available
        if (_selectedCountry != null &&
            _validationRules.containsKey(_selectedCountry!.code)) ...[
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: CustomTextL(
              '${'Example'.tr}: ${_validationRules[_selectedCountry!.code]!.example}',
              fontSize: 12.sp,
              color: TextFieldColors.hintTitle,
              fontWeight: FW.medium,
            ),
          ),
        ],
      ],
    );
  }
}

// Helper class for validation rules
class PhoneValidationRule {
  final RegExp pattern;
  final String example;
  final Map<String, String> message;

  PhoneValidationRule({
    required this.pattern,
    required this.example,
    required this.message,
  });
}
