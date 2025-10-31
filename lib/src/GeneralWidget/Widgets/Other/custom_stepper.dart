import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class MainDivider extends StatelessWidget {
  final double thickness;
  final double? height;

  const MainDivider({
    super.key,
    this.thickness = 4,
    this.height = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
        height: height, thickness: thickness, color: AppColors.dividerGrayF2);
  }
}
