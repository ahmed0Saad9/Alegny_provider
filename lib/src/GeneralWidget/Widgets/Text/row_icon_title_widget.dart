import 'package:flutter/material.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/services/svg_widget.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class RowIconTitle extends StatelessWidget {
  final String icon;
  final String title;
  final double iconSize;
  final Color? color;

  const RowIconTitle(
      {super.key,
      required this.icon,
      required this.title,
      this.iconSize = 24,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 9),
      child: Row(
        children: [
          IconSvg(icon, size: iconSize, color: color),
          10.ESW(),
          Expanded(
            child: CustomTextR(
              title,
              maxLines: 1,
              fontWeight: FW.medium,
              fontSize: 14,
              isOverFlow: true,
              color: color,
            ),
          )
        ],
      ),
    );
  }
}
