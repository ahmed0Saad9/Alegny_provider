import 'package:flutter/material.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class EmailMasked extends StatelessWidget {
  final String email;

  EmailMasked({required this.email});

  @override
  Widget build(BuildContext context) {
    String maskedEmail = maskEmail(email);
    String domainPart = getDomain(email);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          domainPart,
          style: TextStyle(fontSize: 16),
        ),
        4.ESW(),
        Text(
          maskedEmail,
          style: TextStyle(fontSize: 16, letterSpacing: 2),
        ),
      ],
    );
  }

  String maskEmail(String email) {
    int indexOfAt = email.indexOf('@');
    String localPart = email.substring(0, indexOfAt);
    return '●' * localPart.length; // Mask all characters of local part
  }

  String getDomain(String email) {
    int indexOfAt = email.indexOf('@');
    return email.substring(indexOfAt); // Return domain part including @
  }
}
