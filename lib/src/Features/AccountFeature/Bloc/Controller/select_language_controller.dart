import 'dart:async';

import 'package:Alegny_provider/src/core/services/Lang/localization_services.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SelectLanguageController extends GetxController {
  final _box = sl<GetStorage>();
  String selectedLanguage = 'ar';

  void changeLanguage(String languageCode) {
    selectedLanguage = languageCode;
    if (selectedLanguage == 'ar') {
      LocalizationServices().changeLocale("Arabic");
      _box.write("lan", "ar");
      _box.write("language", "arabic");
    } else {
      LocalizationServices().changeLocale("English");
      _box.write("lan", "en");
      _box.write("language", "english");
      selectedLanguage = 'en';
    }

    update(); // To refresh the UI
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
