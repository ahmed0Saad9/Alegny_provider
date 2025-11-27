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
  Timer? _timer;
  int _countdown = 60;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      enableResend = false;
      _countdown = 60;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _timer?.cancel();
          enableResend = true;
        }
      });
    });
  }

  void _resendCode() {
    widget.resendCode();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomTextL.subtitle(
          'I_did_not_get_the_code',
          fontSize: 16,
        ),
        const SizedBox(width: 8),
        // Show countdown timer or resend button
        enableResend
            ? TextButton(
                onPressed: _resendCode,
                child: const CustomTextL(
                  'Resend',
                  fontWeight: FW.bold,
                  fontSize: 16,
                  color: AppColors.main,
                  decoration: CustomTextDecoration.underLine,
                ),
              )
            : Row(
                children: [
                  const CustomTextL(
                    'Resend_in',
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.main.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: CustomTextL(
                      '$_countdown',
                      fontSize: 14,
                      fontWeight: FW.bold,
                      color: AppColors.main,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const CustomTextL(
                    'S',
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ],
              )
      ],
    );
  }
}
