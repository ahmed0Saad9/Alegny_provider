import 'dart:developer';

import 'package:flutter/foundation.dart';

class AppImages {
  static const String _pathImages = 'assets/images/';
  static const String appName = '${_pathImages}a';
  static const String errorImage = '${_pathImages}error_image.png';
}

void printDM(String title) {
  if (kDebugMode) {
    log('----------->>>>>>>>>> $title -----------<<<<<<<<<<<');
  }
}
