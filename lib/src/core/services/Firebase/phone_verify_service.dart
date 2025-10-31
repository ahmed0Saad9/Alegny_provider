// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_base/src/Core/Utils/general_utils.dart';
// import 'package:flutter_base/src/Core/Utils/utils.dart';
// import 'package:flutter_base/src/Shared/Presentation/Widgets/GeneralWidgets/Dialogs/app_dialogs.dart';
// import 'package:get/get.dart';
//
// class PhoneVerifyService {
//   PhoneVerifyService._();
//
//   static final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   static String _egyptianNumber(String phone) {
//     if (phone.startsWith("0")) {
//       phone = phone.replaceFirst("0", "+20");
//     } else if (phone.startsWith("2")) {
//       phone = "+$phone";
//     }
//     printDM("Phone is => $phone");
//     return phone;
//   }
//
//   static String _saudiNumber(String phone) {
//     if (phone.startsWith("0")) {
//       phone = phone.replaceFirst("0", "+966");
//     } else if (phone.startsWith("5")) {
//       phone = "+$phone";
//     }
//     printDM("Phone is => $phone");
//     return phone;
//   }
//
//   static Future<void> verifyPhone({
//     String? phone,
//     Function? onSuccess,
//     bool isRegister = true,
//   }) async {
//     AppDialogs.showLoadingDialog();
//
//     _auth.verifyPhoneNumber(
//       phoneNumber: _egyptianNumber(phone!),
//       timeout: const Duration(seconds: 60),
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         onSuccess!();
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         if (e.code == 'invalid-phone-number') {
//           printDM('The provided phone number is not valid.');
//         }
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         printDM("code sent");
//         // Get.off(() => VerificationCodePage(
//         //       phone: phone,
//         //       register: isRegister,
//         //       onSuccess: (String code) async {
//         //         AppDialogs.showLoadingDialog();
//         //         AuthCredential credential = PhoneAuthProvider.credential(
//         //             verificationId: verificationId, smsCode: code);
//         //         UserCredential result =
//         //             await _auth.signInWithCredential(credential);
//         //         var user = result.user;
//         //         Get.back();
//         //         if (user != null) {
//         //           printDM("success verification");
//         //           onSuccess!();
//         //         } else {
//         //           printDM("an error occur");
//         //         }
//         //       },
//         //     ));
//       },
//       codeAutoRetrievalTimeout: (data) {},
//     );
//   }
// }
