import 'dart:async';

import 'package:flutter/material.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';

class ResendButton extends StatefulWidget {
  final VoidCallback resendCode;

  const ResendButton({super.key, required this.resendCode});

  @override
  _ResendButtonState createState() => _ResendButtonState();
}

class _ResendButtonState extends State<ResendButton> {
  bool enableResend = false;
  Timer? timer;

  @override
  initState() {
    super.initState();

    setState(() {
      enableResend = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomTextL.subtitle(
          'i_did_not_get_the_code',
          fontSize: 16,
        ),
        TextButton(
            onPressed: enableResend
                ? () {
                    widget.resendCode();
                    _resendCode();
                  }
                : null,
            child: const CustomTextL(
              'resend',
              fontWeight: FW.bold,
              fontSize: 16,
              color: AppColors.main,
              decoration: CustomTextDecoration.underLine,
            ))
      ],
    );
  }

  void _resendCode() {
    //other code here
    setState(() {
      enableResend = false;
    });
  }
}
