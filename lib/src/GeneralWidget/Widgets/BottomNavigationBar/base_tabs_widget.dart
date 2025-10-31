import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';

class BaseTabsWidget extends StatelessWidget {
  final List<Widget> children;

  const BaseTabsWidget({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24.r),
          ),
          color: Colors.white,
          boxShadow: AppColors.cardShadowBlack),
      child: Row(
        children: children,
      ),
    );
  }
}
