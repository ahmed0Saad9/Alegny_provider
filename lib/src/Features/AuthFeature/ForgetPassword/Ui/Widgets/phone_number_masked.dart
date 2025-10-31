import 'package:flutter/material.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class PhoneNumberMasked extends StatelessWidget {
  final String phoneNumber;

  const PhoneNumberMasked({required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    String maskedNumber = maskPhoneNumber(phoneNumber);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          phoneNumber.substring(phoneNumber.length - 4),
          style: const TextStyle(fontSize: 16),
        ),
        4.ESW(),
        Text(
          maskedNumber,
          style: const TextStyle(fontSize: 16, letterSpacing: 2),
        ),
      ],
    );
  }

  String maskPhoneNumber(String number) {
    return '●●●● ●●● '; // Create as many dots as needed for the hidden portion
  }
}
