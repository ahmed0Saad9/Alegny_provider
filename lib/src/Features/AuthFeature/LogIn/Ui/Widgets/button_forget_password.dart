import 'package:flutter/material.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';

import '/src/core/utils/extensions.dart';

class ButtonForgetPassword extends StatelessWidget {
  final VoidCallback onTap;

  const ButtonForgetPassword({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        0.ESH(),
        TextButton(
          onPressed: onTap,
          child: const CustomTextL(
            "نسيت كلمة المرور ؟",
            fontWeight: FW.bold,
            fontSize: 12,
            color: AppColors.titleGray65,
          ),
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
        ),
      ],
    );
  }
}
