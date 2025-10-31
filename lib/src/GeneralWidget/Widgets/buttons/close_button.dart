import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';

import '../../../core/services/svg_widget.dart';

class CustomCloseButton extends StatelessWidget {
  final double size;
  final Color? color;
  const CustomCloseButton({
    this.size = 14,
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2.w,
          color: color ?? AppColors.iconBlack,
        ),
      ),
      child: Center(
        child: IconSvg(
          'close_icon',
          size: size,
          color: color ?? AppColors.iconBlack,
        ),
      ),
    );
  }
}
