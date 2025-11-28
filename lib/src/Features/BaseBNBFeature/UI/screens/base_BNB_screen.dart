import 'package:Alegny_provider/src/Features/AddServiceFeature/UI/screens/add_service_screen.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/BottomNavigationBar/base_icon_widget.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/BottomNavigationBar/base_tabs_widget.dart';

import '../../Bloc/Controller/base_BNB_controller.dart';
import '../../Bloc/Model/base_BNB_model.dart';

class BaseBNBScreen extends StatelessWidget {
  const BaseBNBScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BaseNBNController());
    return GetBuilder<BaseNBNController>(
      builder: (_) => WillPopScope(
        onWillPop: _.willPopCallback,
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: adminBaseModels[_.bottomNavIndex].child,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  BaseTabsWidget(
                    children: [
                      // First tab
                      Expanded(
                        child: BaseIconWidget(
                          icon: adminBaseModels[0].icon,
                          title: adminBaseModels[0].title,
                          onTap: () {
                            _.updateIndex(adminBaseModels[0].id);
                          },
                          active: _.bottomNavIndex == adminBaseModels[0].id,
                        ),
                      ),
                      // Empty space for FAB
                      SizedBox(width: 80.w),
                      // Second tab
                      Expanded(
                        child: BaseIconWidget(
                          icon: adminBaseModels[1].icon,
                          title: adminBaseModels[1].title,
                          onTap: () {
                            _.updateIndex(adminBaseModels[1].id);
                          },
                          active: _.bottomNavIndex == adminBaseModels[1].id,
                        ),
                      ),
                    ],
                  ),
                  // Floating Action Button
                  Positioned(
                    top: -20.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.main,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.main.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            Get.to(() => const AddServiceScreen());
                          },
                          icon: Icon(
                            Icons.add,
                            color: AppColors.iconWight,
                            size: 30.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
