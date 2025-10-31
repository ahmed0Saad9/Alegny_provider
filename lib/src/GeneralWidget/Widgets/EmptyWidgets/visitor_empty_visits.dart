import 'package:flutter/material.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/services/svg_widget.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class EmptyWidget extends StatelessWidget {
  final String? image;
  final String title;
  final Color? color;
  const EmptyWidget({
    Key? key,
    this.image,
    required this.title,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (image != null)
            AssetSvg(
              image!,
            ),
          16.ESH(),
          CustomTextL(
            title,
            fontSize: 14,
            fontWeight: FW.medium,
            color: color ?? AppColors.titleBlack.withOpacity(.44),
          ),
        ],
      ),
    );
  }
}
