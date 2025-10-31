import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/services/svg_widget.dart';
import '../Text/custom_text.dart';

class BaseIconWidget extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;
  final bool active;

  const BaseIconWidget({
    super.key,
    required this.onTap,
    this.active = false,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: IconSvg(
                icon,
                size: 23,
                color: active ? const Color(0xff28895E) : AppColors.iconBlack,
                boxFit: BoxFit.fill,
              ),
            ),
            6.ESH(),
            CustomTextL(
              title,
              color: active ? const Color(0xff28895E) : AppColors.titleBlack,
              fontWeight: FW.medium,
              fontSize: 12,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
