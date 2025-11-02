// part of '../screens/profile_screen.dart';
//
// class _CardAccountDetails extends StatelessWidget {
//   final Profile profile;
//   const _CardAccountDetails({
//     super.key,
//     required this.profile,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProfileController>(
//       init: ProfileController(),
//       builder: (c) => Container(
//         width: Get.width,
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 30,
//               offset: const Offset(0, 10),
//             )
//           ],
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10.r),
//         ),
//         padding: AppPadding.paddingScreenSH16,
//         child: Column(
//           children: [
//             Container(
//               height: 50.h,
//               width: Get.width,
//               decoration: const BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(
//                     color: AppColors.dividerGrayD0,
//                     width: 0.5,
//                   ),
//                 ),
//               ),
//               child: Center(
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     CustomTextL.title(
//                       "personal_data",
//                       fontSize: 14,
//                     ),
//                     const Spacer(),
//                     InkWell(
//                       onTap: () {
//                         Get.to(() => const EditProfileScreen());
//                       },
//                       child: Row(
//                         children: [
//                           CustomTextL.title(
//                             "edit",
//                             fontSize: 13,
//                             decoration: CustomTextDecoration.underLine,
//                             color: AppColors.main,
//                           ),
//                           const IconSvg(
//                             'Edit',
//                             color: AppColors.main,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             ListPersonalData(
//               userData: profile,
//             ),
//             6.ESH(),
//             Row(
//               children: [
//                 const IconSvg(
//                   'Lock',
//                   color: AppColors.iconGray95,
//                   size: 20,
//                   boxFit: BoxFit.fill,
//                 ),
//                 9.ESW(),
//                 CustomTextL.title(
//                   "Password",
//                   fontSize: 14,
//                   color: AppColors.titleGray54,
//                 ),
//                 const Spacer(),
//                 InkWell(
//                   onTap: () {
//                     Get.to(() => const ResetPasswordScreen());
//                   },
//                   child: Container(
//                     padding: AppPadding.paddingScreenSH8SV8,
//                     decoration: BoxDecoration(
//                       color: AppColors.main,
//                       borderRadius: BorderRadius.circular(30.r),
//                     ),
//                     child: const Center(
//                       child: CustomTextL(
//                         "change",
//                         color: AppColors.titleWhite,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             20.ESH(),
//           ],
//         ),
//       ),
//     );
//   }
// }
