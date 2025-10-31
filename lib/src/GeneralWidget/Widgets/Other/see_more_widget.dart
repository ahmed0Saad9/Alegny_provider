import 'package:flutter/material.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/services/svg_widget.dart';
import '../Text/custom_text.dart';

class SeeMoreWidget extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const SeeMoreWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.paddingScreenSH16,
      child: Row(
        children: [
          CustomTextL(title, fontWeight: FW.bold, fontSize: 15),
          4.ESW(),
          IconSvg(icon),
          const Spacer(),
          TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: const CustomTextL(
              "show_all",
              decoration: CustomTextDecoration.underLine,
            ),
          )
        ],
      ),
    );
  }
}
