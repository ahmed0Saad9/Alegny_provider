import 'package:Alegny_provider/src/core/services/Network/network_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class ThemeManagerController extends GetxController {
  final GetStorage _box = Get.put(GetStorage());

  final String themeColor = "#8D0036";

  Color mainColor() {
    return HexColor.fromHex(themeColor);
  }

  void init() {
    Get.put(NetworkService());
  }

  @override
  void onInit() {
    super.onInit();
    _box.write('themeColor', themeColor);
    init();

    // ThemeMode _themeMode = ThemeMode.light;
    //
    // ThemeMode get themeMode => _themeMode;
    //
    // toggleTheme(bool isDark){
    //   _themeMode = isDark?ThemeMode.dark:ThemeMode.light;
    //   update();
    // }
  }
}
