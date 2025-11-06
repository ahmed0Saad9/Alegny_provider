import 'package:get/get.dart';

String? nameValidator(String? text) {
  if (text == null || text.isEmpty) {
    return 'Please enter your name'.tr;
  }

  RegExp regex = RegExp(r'^[a-zA-Z ]+$');
  if (!regex.hasMatch(text)) {
    return 'Please enter alphabets only'.tr;
  }
  if (text.length > 50) {
    return 'Maximum 50 characters allowed'.tr;
  }

  return null;
}

String? emailValidator(String? text) {
  if (text == null || text.isEmpty) {
    return 'Please enter an email'.tr;
  }

  RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    caseSensitive: false,
  );

  if (!emailRegex.hasMatch(text)) {
    return 'Please enter a valid email'.tr;
  }

  return null;
}

String? passwordValidator(String? text) {
  if (text == null || text.isEmpty) {
    return 'Password is required'.tr;
  }

  RegExp regex = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  );

  if (!regex.hasMatch(text)) {
    return 'Password_must_contain_symbols_Letters_numbers'.tr;
  }

  return null;
}

String? confirmPasswordValidator(String? text, String? password) {
  if (text == null || text.isEmpty) {
    return 'Please confirm your password'.tr;
  }

  if (text != password) {
    return 'Passwords do not match'.tr;
  }

  return null;
}

String? collegeIdValidator(String? text) {
  if (text == null || text.isEmpty) {
    return 'College ID is required'.tr;
  }

  if (text.length != 5) {
    return 'College ID must be 5 digits'.tr;
  }

  if (!RegExp(r'^[0-9]+$').hasMatch(text)) {
    return 'College ID must contain numbers only'.tr;
  }

  return null;
}

String? nationalIdValidator(String? text) {
  if (text == null || text.isEmpty) {
    return 'National ID is required'.tr;
  }

  if (text.length != 14) {
    return 'National ID must be 14 digits'.tr;
  }

  if (!RegExp(r'^[0-9]+$').hasMatch(text)) {
    return 'National ID must contain numbers only'.tr;
  }

  return null;
}

String? emptyValidator(String? text, {String? errorMessage}) {
  if (text == null || text.isEmpty) {
    return errorMessage?.tr ?? 'This field is required'.tr;
  }
  return null;
}
