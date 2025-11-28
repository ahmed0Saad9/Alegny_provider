import 'package:Alegny_provider/src/Features/AddServiceFeature/UI/screens/add_service_screen.dart';
import 'package:Alegny_provider/src/Features/HomeFeature/Bloc/controller/services_controller.dart';
import 'package:Alegny_provider/src/Features/HomeFeature/Bloc/model/service_model.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Appbars/app_bars.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/base_scaffold.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';

import '../Widgets/service_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBars.appBarHome(
        bNBIndex: 0,
      ),
      body: GetBuilder<ServicesController>(
        init: ServicesController(),
        builder: (controller) => Stack(
          children: [
            // Use RefreshIndicator for both empty and non-empty states
            RefreshIndicator(
              onRefresh: () async => controller.fetchServices(),
              child: controller.services.isEmpty
                  ? _buildEmptyStateWithScroll() // Use scrollable empty state
                  : _buildServicesList(controller),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesList(ServicesController controller) {
    return ListView.builder(
      padding: AppPadding.paddingScreenSV16,
      itemCount: controller.services.length,
      itemBuilder: (context, index) {
        return ServiceCard(
          service: controller.services[index],
          onEdit: () {
            print('Edit service: ${controller.services[index].id}');
            Get.to(() =>
                AddServiceScreen(serviceToEdit: controller.services[index]));
          },
          onDelete: () {
            controller.deleteService(controller.services[index].id);
          },
        );
      },
    );
  }

  Widget _buildEmptyStateWithScroll() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(), // Always allow scrolling
      child: SizedBox(
        height: Get.height * 0.8, // Make it tall enough to pull down
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.medical_services_outlined,
                size: 80.sp,
                color: AppColors.main,
              ),
              16.ESH(),
              CustomTextL(
                'No_services_yet',
                fontSize: 18.sp,
                fontWeight: FW.bold,
                color: Colors.grey[600],
              ),
              8.ESH(),
              CustomTextL(
                'Tap_add_service_to_create_services',
                fontSize: 14.sp,
                color: Colors.grey[500],
                textAlign: TextAlign.center,
              ),
              16.ESH(),
            ],
          ),
        ),
      ),
    );
  }
}
