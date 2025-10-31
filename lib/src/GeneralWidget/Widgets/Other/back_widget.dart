import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/core/ThemeData/theme_manager.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => Get.back(),
      child: SizedBox(
        child: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: sl<ThemeManagerController>().mainColor(),
        ).paddingAll(8),
      ),
    );
  }
}
