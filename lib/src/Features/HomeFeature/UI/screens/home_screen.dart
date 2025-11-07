import 'package:Alegny_provider/src/Features/AddServiceFeature/UI/screens/add_service_screen.dart';
import 'package:Alegny_provider/src/Features/HomeFeature/Bloc/model/service_model.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Appbars/app_bars.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/base_scaffold.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';

import '../Widgets/service_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ServiceModel> services = [];
    // List<ServiceModel> services = [
    //   ServiceModel(
    //     id: "1",
    //     serviceName: "Dr. Ahmed Cardiology Center",
    //     serviceType: "human_doctor",
    //     specialization: "Cardiology",
    //     imageUrl: "https://example.com/images/cardiology-center.jpg",
    //     discounts: {"bloodTest": "20%", "xray": "15%"},
    //     status: ServiceStatus.pending,
    //     branches: [
    //       BranchModel(
    //         governorate: "القاهرة",
    //         city: "المعادي",
    //         address: "123 شارع النصر، المعادي، القاهرة",
    //         phone: "01234567891",
    //         whatsapp: "01234567891",
    //         workingHours: {
    //           'saturday': '9:00 AM - 5:00 PM',
    //           'sunday': '9:00 AM - 5:00 PM',
    //           'monday': '9:00 AM - 5:00 PM',
    //           'tuesday': '9:00 AM - 5:00 PM',
    //           'wednesday': '9:00 AM - 5:00 PM',
    //           'thursday': '9:00 AM - 2:00 PM',
    //           'friday': 'closed',
    //         },
    //       ),
    //       BranchModel(
    //         governorate: "الجيزة",
    //         city: "الدقي",
    //         address: "45 شارع جامعة القاهرة، الدقي",
    //         phone: "01234567892",
    //         whatsapp: "01234567892",
    //         workingHours: {
    //           'saturday': '10:00 AM - 6:00 PM',
    //           'sunday': '10:00 AM - 6:00 PM',
    //           'monday': '10:00 AM - 6:00 PM',
    //           'tuesday': '10:00 AM - 6:00 PM',
    //           'wednesday': '10:00 AM - 6:00 PM',
    //           'thursday': '10:00 AM - 4:00 PM',
    //           'friday': 'closed',
    //         },
    //       ),
    //       BranchModel(
    //         // Third branch
    //         governorate: "القاهرة",
    //         city: "مدينة نصر",
    //         address: "78 شارع مكرم عبيد، مدينة نصر",
    //         phone: "01234567893",
    //         whatsapp: "01234567893",
    //         workingHours: {
    //           'saturday': '8:00 AM - 8:00 PM',
    //           'sunday': '8:00 AM - 8:00 PM',
    //           'monday': '8:00 AM - 8:00 PM',
    //           'tuesday': '8:00 AM - 8:00 PM',
    //           'wednesday': '8:00 AM - 8:00 PM',
    //           'thursday': '8:00 AM - 4:00 PM',
    //           'friday': '10:00 AM - 2:00 PM',
    //         },
    //       ),
    //     ],
    //   ),
    //   ServiceModel(
    //     id: "4",
    //     serviceName: "Advanced Medical Lab",
    //     serviceType: "lab",
    //     specialization: null,
    //     imageUrl: "https://example.com/images/medical-lab.jpg",
    //     discounts: {},
    //     status: ServiceStatus.approved,
    //     branches: [
    //       BranchModel(
    //         governorate: "الدقهلية",
    //         city: "المنصورة",
    //         address: "شارع الجمهورية، المنصورة",
    //         phone: "01234567896",
    //         whatsapp: "01234567896",
    //         workingHours: {
    //           'saturday': '7:00 AM - 10:00 PM',
    //           'sunday': '7:00 AM - 10:00 PM',
    //           'monday': '7:00 AM - 10:00 PM',
    //           'tuesday': '7:00 AM - 10:00 PM',
    //           'wednesday': '7:00 AM - 10:00 PM',
    //           'thursday': '7:00 AM - 10:00 PM',
    //           'friday': '7:00 AM - 10:00 PM',
    //         },
    //       ),
    //     ],
    //   ),
    // ];
    return BaseScaffold(
      appBar: AppBars.appBarHome(
        bNBIndex: 0,
      ),
      body: Padding(
        padding: AppPadding.paddingScreenSH16SV16,
        child: Stack(
          children: [
            services.isEmpty
                ? _buildEmptyState()
                : Padding(
                    padding: EdgeInsets.only(bottom: 60.h),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        return ServiceCard(
                          service: services[index],
                          onEdit: () {
                            // Navigate to edit service screen
                            print('Edit service: ${services[index].id}');
                            // Get.to(() => EditServiceScreen(service: services[index]));
                          },
                          onDelete: () {
                            // Call delete API
                            print('Delete service: ${services[index].id}');
                            // Your delete logic here
                            Get.snackbar(
                              'success'.tr,
                              'service_deleted_successfully'.tr,
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );
                          },
                          onViewDetails: () {
                            print(
                                'View details: ${services[index].serviceName}');
                          },
                        );
                      },
                    ),
                  ),
            Align(
              alignment: AlignmentDirectional.bottomStart,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: AppColors.main),
                    child: IconButton(
                      onPressed: () {
                        Get.to(() => const AddServiceScreen());
                      },
                      icon: const Icon(
                        Icons.add,
                        color: AppColors.iconWight,
                      ),
                    ),
                  ),
                  10.ESW(),
                  CustomTextL(
                    'Add_Service',
                    fontSize: 18.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildEmptyState() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.medical_services_outlined,
          size: 80.sp,
          color: AppColors.main,
        ),
        CustomTextL(
          'No_services_yet',
          fontSize: 18.sp,
          fontWeight: FW.bold,
          color: Colors.grey[600],
        ),
        CustomTextL(
          'Tap_add_service_to_create_services',
          fontSize: 18.sp,
          color: Colors.grey[500],
        ),
      ],
    ),
  );
}
