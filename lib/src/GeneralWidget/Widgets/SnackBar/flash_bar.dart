// import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
// import 'package:Alegny_provider/src/core/constants/color_constants.dart';
// import 'package:flash/flash.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class FlashHelper {
//   static void showTopFlash(String? msg,
//       {bool persistent = true,
//         Color bckColor = AppColors.warningSnackBar,
//         String title = "",
//         bool showDismiss = false}) {
//     showFlash(
//       context: Get.context!,
//       duration: const Duration(seconds: 5),
//       persistent: persistent,
//       builder: (_, controller.) {
//
//         return Flash(
//           controller: controller,
//           backgroundColor: bckColor,
//           brightness: Brightness.light,
//           boxShadows: const [BoxShadow(blurRadius: 0)],
//           barrierBlur: 0.0,
//           barrierColor: Colors.black38,
//           barrierDismissible: true,
//           behavior: FlashBehavior.fixed,
//           position: FlashPosition.top,
//           child: FlashBar(
//             title: title.isEmpty
//                 ? null
//                 : CustomTextL(
//               title,
//               textAlign: TextAlign.center,
//               color: AppColors.titleWight,
//               fontWeight: FW.bold,
//             ),
//             content: Center(
//               child:CustomTextL(
//                 msg != null && msg.isNotEmpty ? msg : 'error_code'.tr,
//                 textAlign: TextAlign.center,
//                 color: AppColors.titleWight,
//               ),
//             ),
//             showProgressIndicator: false,
//             primaryAction: null,
//           ),
//         );
//       },
//     );
//   }
// }
