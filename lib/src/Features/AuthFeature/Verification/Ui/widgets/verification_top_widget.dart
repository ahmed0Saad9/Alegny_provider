import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class VerificationTopWidget extends StatelessWidget {
  // final String phone;
  final String email;
  final String title;

  const VerificationTopWidget(
      {
      // required this.phone,
      required this.email,
      super.key,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            CustomTextL.title(
              title,
            ),
          ],
        ),
        14.0.ESH(),
        Image.asset(
          'assets/images/AccountVerification.png',
          width: 295.w,
          height: 287.h,
        ),
        14.ESH(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextL.subtitle(
              'we_will_send_verification_code_to_your_phone',
            ),
            4.ESH(),
            CustomTextR.subtitle(
              email,
              fontWeight: FW.bold,
            ),
            4.ESH(),
            CustomTextL.subtitle(
              'please_type_this_code_below_for_the_next_step',
            ),
          ],
        ),
      ],
    );
  }
}
