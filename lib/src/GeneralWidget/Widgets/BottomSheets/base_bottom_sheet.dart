import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/services/svg_widget.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

import '../../../core/constants/sizes.dart';

class BaseBottomSheet extends StatelessWidget {
  final Widget widget;
  final double height;
  final String? title;
  final double? titleSize;
  final String? icon;
  final String? image;
  final double spaceBHeaderAndWidget;
  final VoidCallback? onCloseTap;
  final bool enableBck;

  const BaseBottomSheet({
    this.title,
    required this.widget,
    this.height = 461,
    this.enableBck = false,
    this.spaceBHeaderAndWidget = 36,
    super.key,
    this.onCloseTap,
    this.icon,
    this.image,
    this.titleSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: AppPadding.paddingScreenSH36,
        width: double.infinity,
        height: height.h,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(37.r),
              topRight: Radius.circular(37.r),
            ),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.ESH(),
            Center(
              child: Container(
                width: 174.w,
                height: 7.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFC4C4C4),
                  borderRadius: BorderRadius.circular(46.r),
                ),
              ),
            ),
            10.ESH(),
            Row(
              children: [
                if (icon != null && image == null)
                  IconSvg(
                    icon!,
                    size: 24,
                    boxFit: BoxFit.fill,
                  ),
                if (icon == null && image != null)
                  Image.asset(
                    image!,
                    height: 47.h,
                    width: 47.w,
                  ),
                16.ESW(),
                if (title != null)
                  CustomTextL.header(
                    title!,
                    fontSize: titleSize!,
                  ),
                const Spacer(),
              ],
            ),
            spaceBHeaderAndWidget.ESH(),
            Expanded(child: widget)
          ],
        ),
      ),
    );
  }
}

Future<dynamic> showButtonSheet(BuildContext context, Widget widget) {
  return showModalBottomSheet(
    isDismissible: true,
    backgroundColor: Colors.transparent,
    enableDrag: true,
    isScrollControlled: true,
    clipBehavior: Clip.hardEdge,
    context: context,
    builder: (BuildContext context) {
      return widget;
    },
  );
}
