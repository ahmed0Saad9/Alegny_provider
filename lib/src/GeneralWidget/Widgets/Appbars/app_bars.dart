import 'dart:ui';

import 'package:Alegny_provider/src/Features/BaseBNBFeature/Bloc/Controller/base_BNB_controller.dart';
import 'package:Alegny_provider/src/Features/NotificationFeature/Bloc/Controller/notification_controller.dart';
import 'package:Alegny_provider/src/Features/NotificationFeature/UI/screens/notifications_screen.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Cards/card_avatar_image.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:Alegny_provider/src/core/utils/storage_util.dart';

import '../../../core/services/svg_widget.dart';

class AppBars {
  static AppBar appBarDefault({
    bool isBack = true,
    bool bottomDivider = false,
    TabBar? tabBar,
    String title = '',
    VoidCallback? onTapBack,
    Color backgroundColor = AppColors.transparentColor,
    Widget secondIconImage = const SizedBox(
      width: 0,
    ),
    VoidCallback? onTap,
    Color? iconcolor,
    Color? titleColor,
  }) {
    return AppBar(
      title: CustomTextL(
        title.tr,
        fontWeight: FW.bold,
        fontSize: 32,
        textAlign: TextAlign.start,
        color: titleColor,
      ),
      titleSpacing: 8.w,
      backgroundColor: backgroundColor,
      centerTitle: true,
      elevation: 0.0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: Container(
          color: AppColors.dividerGrayD0,
          height: bottomDivider ? 0.5 : 0.0,
        ),
      ),
      leading: isBack == false
          ? 0.0.ESH()
          : IconButton(
              onPressed: () => Get.back(),
              icon: const IconSvg(
                'arrow-back',
              ),
            ),
      actions: [secondIconImage],
    );
  }

  static AppBar appBarBack(
      {bool isBack = true,
      TabBar? tabBar,
      String title = '',
      VoidCallback? onTapBack,
      Color backgroundColor = AppColors.main,
      Widget secondIconImage = const SizedBox(
        width: 0,
      ),
      VoidCallback? onTap,
      Color? iconcolor,
      Color? titleColor = AppColors.titleWhite}) {
    return AppBar(
      scrolledUnderElevation: 0,
      titleSpacing: 8.w,
      backgroundColor: backgroundColor,
      centerTitle: true,
      elevation: 0.0,
      title: CustomTextL(
        title.tr,
        fontWeight: FW.bold,
        fontSize: 24,
        textAlign: TextAlign.center,
        color: titleColor,
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: Container(
          color: AppColors.dividerGrayD0,
        ),
      ),
      leading: isBack == true
          ? IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            )
          : 0.0.ESH(),
      actions: [secondIconImage],
    );
  }

  static AppBar appBarSkipDefault(
      {bool isBack = true,
      TabBar? tabBar,
      String title = '',
      Widget secondIconImage = const SizedBox(
        width: 0,
      ),
      VoidCallback? onTapBack,
      VoidCallback? onTapSkip,
      bool isSkip = false}) {
    return AppBar(
      title: CustomTextL(
        title,
        fontWeight: FW.medium,
        fontSize: 16,
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0.0,
      leading: isBack == false ? 0.0.ESH() : CustomIconBack(onTap: onTapBack),
      actions: [
        isSkip == true
            ? SizedBox(
                width: 60.w,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: onTapSkip,
                  icon: const CustomTextL(
                    "skip_",
                    fontWeight: FW.medium,
                    fontSize: 12,
                  ),
                ),
              )
            : 0.0.ESH()
      ],
      bottom: tabBar,
    );
  }

  // static AppBar appBarHome({
  //   required int bNBIndex,
  // }) {
  //   return AppBar(
  //     scrolledUnderElevation: 0,
  //     title: Padding(
  //       padding: AppPadding.paddingScreenSH16,
  //       child: Column(
  //         // crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             children: [
  //               const Column(
  //                 children: [
  //                   CustomTextL(
  //                     'Hello',
  //                     fontWeight: FW.bold,
  //                     color: AppColors.titleWhite,
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(
  //                 width: 160.w,
  //                 child: CustomTextR(
  //                   ", ${sl<GetStorage>().read(
  //                     "UserName",
  //                   )}",
  //                   isOverFlow: true,
  //                   color: AppColors.titleWhite,
  //                   fontWeight: FW.bold,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //     backgroundColor: AppColors.main,
  //     elevation: 0.0,
  //     actions: [
  //       Padding(
  //         padding: AppPadding.paddingScreenSH16SV8,
  //         child: InkWell(
  //           onTap: () => Get.to(() => const NotificationsScreen()),
  //           borderRadius: BorderRadius.circular(555.r),
  //           child: Container(
  //             // margin: EdgeInsets.symmetric(horizontal: 16.w),
  //             width: 35.w,
  //             decoration: const BoxDecoration(
  //               shape: BoxShape.circle,
  //               color: AppColors.titleWhite,
  //             ),
  //             child: Center(
  //               child: IconSvg(
  //                 'Notification',
  //                 color: AppColors.main,
  //                 height: 30.h,
  //                 boxFit: BoxFit.contain,
  //               ),
  //             ),
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  static AppBar appBarHome({
    required int bNBIndex,
    bool hasUnreadNotifications = true,
  }) {
    return AppBar(
      scrolledUnderElevation: 0,
      toolbarHeight: 70.h,
      backgroundColor: AppColors.main,
      elevation: 0.0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.main,
              AppColors.main.withOpacity(0.85),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            // Avatar
            GetBuilder<BaseNBNController>(
              builder: (controller) => InkWell(
                onTap: () => controller.updateIndex(1),
                child: Container(
                  width: 45.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: AvatarWidget(
                      height: 45,
                      width: 45,
                      image: sl<GetStorage>().read("userImage"),
                    ),
                  ),
                ),
              ),
            ),
            12.ESW(),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextL(
                    'Hello',
                    fontSize: 20.sp,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FW.regular,
                  ),
                  // 2.ESH(),
                  Expanded(
                    child: CustomTextL(
                      ', ${sl<GetStorage>().read('firstName') ?? 'user'}',
                      fontSize: 20.sp,
                      color: AppColors.titleWhite,
                      fontWeight: FW.bold,
                      isOverFlow: true,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        // Notification Button

        Padding(
          padding: EdgeInsetsDirectional.only(end: 16.w, top: 10.h),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              InkWell(
                onTap: () => Get.to(() => const NotificationsScreen()),
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  width: 45.w,
                  height: 45.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: IconSvg(
                      'Notification',
                      color: AppColors.iconWight,
                      height: 22.h,
                      boxFit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static AppBar appBarInvestmentPortfolio({
    required int bNBIndex,
  }) {
    return AppBar(
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextL(
                    "good_morning".tr,
                    fontSize: 12,
                    color: AppColors.titleWhite,
                  ),
                  const CustomTextR(
                    'احمد دومة',
                    color: AppColors.titleWhite,
                  ),
                ],
              ),
              CustomTextL(
                "trade_your_points_with_us_now".tr,
                color: AppColors.titleWhite,
              ),
            ],
          ),
        ],
      ),
      leading: IconButton(
        icon: CardAvatarImage(
            size: 40,
            image: LocalStorageCubit().getItem(
                  key: 'avatar',
                ) ??
                ''),
        tooltip: 'Open Profile',
        onPressed: () {},
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: [
        if (bNBIndex == 0 || bNBIndex == 1)
          const Center(
            child: NotificationWidget(
              glassy: true,
              endPadding: 0,
            ),
          ),
        IconButton(
          onPressed: () {},
          icon: Padding(
            padding: EdgeInsetsDirectional.only(end: 0.w),
            child: SizedBox(
              width: 40.w,
              height: 40.h,
              child: InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.backGroundIconGreyF5.withOpacity(0.10),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: IconSvg(
                        'search',
                        color: Colors.white,
                        size: 18,
                        boxFit: BoxFit.fill,
                      ),
                    ),
                  )),
            ),
          ),
        )
      ],
    );
  }
}

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
    required this.glassy,
    this.endPadding = 16,
  });

  final double? endPadding;
  final bool glassy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: endPadding!),
      child: SizedBox(
        width: 40.w,
        height: 40.h,
        child: InkWell(
          onTap: () {},
          child: Stack(
            children: [
              glassy
                  ? Container(
                      decoration: BoxDecoration(
                        color: AppColors.backGroundIconGreyF5.withOpacity(0.10),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                          child: IconSvg(
                        'notification',
                        color: Colors.white,
                      )),
                    )
                  : Container(
                      decoration: const BoxDecoration(
                        color: AppColors.backGroundIconGreyF5,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(child: IconSvg('notification')),
                    ),
              Visibility(
                visible: true,
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    backgroundColor: AppColors.titleRedFF,
                    radius: 5.r,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomIconBack extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? iconcolor;

  const CustomIconBack({
    super.key,
    this.onTap,
    this.iconcolor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: onTap ??
          () {
            Get.back();
          },
      icon: IconSvg(
        'arrow-back',
        size: 24,
        color: iconcolor,
      ),
    );
  }
}
