// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:Alegny/src/GeneralWidget/Widgets/Text/custom_text.dart';
// import 'package:Alegny/src/core/constants/color_constants.dart';
// import 'package:Alegny/src/core/constants/sizes.dart';
// import 'package:Alegny/src/core/services/svg_widget.dart';
// import 'package:Alegny/src/core/utils/extensions.dart';
//
// import '../../../../../GeneralWidget/Widgets/Other/avatar_widget.dart';
// import '../../Bloc/Controller/edit_general_profile_controller.dart';
//
// class PersonalDataScreen extends StatelessWidget {
//   const PersonalDataScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<EditProfileController>(
//       init: EditProfileController(),
//       builder: (controller) => Scaffold(
//         backgroundColor: AppColors.scaffoldBackGround,
//         body: Stack(
//           children: [
//             Container(
//               height: 376.h,
//               width: Get.width,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage('assets/images/Gradiant.png'),
//                     fit: BoxFit.fill),
//               ),
//             ),
//             Padding(
//               padding: AppPadding.paddingScreenSH16,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   60.ESH(),
//                   SizedBox(
//                     height: 20,
//                     width: 20,
//                     child: IconButton(
//                       padding: EdgeInsets.zero,
//                       onPressed: () {
//                         Get.back();
//                       },
//                       icon: const IconSvg(
//                         'back',
//                         boxFit: BoxFit.fill,
//                         color: AppColors.iconGray29,
//                       ),
//                     ),
//                   ),
//                   16.ESH(),
//                   Center(
//                     child: SizedBox(
//                       height: 100.h,
//                       width: 100.w,
//                       child: Stack(
//                         children: [
//                           AvatarWidget(
//                             imageFile: controller.image?.media,
//                             width: 80,
//                             height: 80,
//                           ),
//                           Align(
//                             alignment: AlignmentDirectional.bottomStart,
//                             child: IconButton(
//                               constraints: const BoxConstraints(
//                                   minWidth: 24, minHeight: 24),
//                               padding: EdgeInsets.zero,
//                               onPressed: () {
//                                 controller.setImageFromGallery();
//                               },
//                               icon: const IconSvg(
//                                 'change_image',
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   24.ESH(),
//                   const _CardAccountDetails(),
//                   16.ESH(),
//                   const _LogOutButton(),
//                   16.ESH(),
//                   const _DeleteAccountButton(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _DeleteAccountButton extends StatelessWidget {
//   const _DeleteAccountButton({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {},
//       child: Container(
//         height: 50.h,
//         width: Get.width,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(6.r),
//           color: AppColors.backGroundRedFD.withOpacity(0.10),
//         ),
//         child: const Center(
//             child: CustomTextL("delete_account",
//                 fontSize: 13, color: AppColors.titleRedFD)),
//       ),
//     );
//   }
// }
//
// class _LogOutButton extends StatelessWidget {
//   const _LogOutButton({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {},
//       child: Container(
//         height: 50.h,
//         width: Get.width,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(6.r),
//           color: AppColors.darkBackGroung.withOpacity(0.10),
//         ),
//         child: const Center(
//             child: CustomTextL("log_out",
//                 fontSize: 13, color: AppColors.titleBlack0B)),
//       ),
//     );
//   }
// }
