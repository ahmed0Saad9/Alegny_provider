import 'package:Alegny_provider/src/Features/AddServiceFeature/UI/screens/add_service_screen.dart';
import 'package:Alegny_provider/src/Features/HomeFeature/Bloc/controller/services_controller.dart';
import 'package:Alegny_provider/src/Features/HomeFeature/Bloc/model/service_model.dart';
import 'package:Alegny_provider/src/core/services/svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../AddServiceFeature/Bloc/controller/add_service_controller.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ServiceCard({
    super.key,
    required this.service,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final bool isArabic = Get.locale?.languageCode == 'ar';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Badge
          _buildStatusHeader(),

          // Header with Image and Basic Info
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _getHeaderGradientColors(),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                // Service Image with Status Indicator
                Stack(
                  children: [
                    Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(555.r),
                        child: service.imageUrl != null
                            ? Image.network(
                                service.imageUrl!,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    _buildPlaceholderImage(),
                              )
                            : _buildPlaceholderImage(),
                      ),
                    ),
                    // Online status indicator for approved services
                    if (service.status == ServiceStatus.approved)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 16.w,
                          height: 16.w,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                16.ESW(),

                // Service Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextL(
                              service.serviceName,
                              fontSize: 18.sp,
                              fontWeight: FW.bold,
                              color: Colors.grey[900],
                              maxLines: 2,
                              isOverFlow: true,
                            ),
                          ),
                        ],
                      ),
                      6.ESH(),

                      ...[
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.main.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: CustomTextL(
                            service.serviceType,
                            fontSize: 14.sp,
                            color: AppColors.main,
                            fontWeight: FW.medium,
                            maxLines: 2,
                            isOverFlow: true,
                          ),
                        ),
                        6.ESH(),
                      ],

                      // Service Type
                      if (service.specialization != null)
                        CustomTextR(
                          service.specialization!.tr,
                          fontSize: 13.sp,
                          color: Colors.grey[600],
                        ),

                      4.ESH(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (service.description != null && service.description!.isNotEmpty)
            Container(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.description_outlined,
                        size: 20.sp,
                        color: AppColors.main,
                      ),
                      6.ESW(),
                      CustomTextL(
                        'service_description',
                        fontSize: 14.sp,
                        fontWeight: FW.bold,
                        color: Colors.grey[800],
                      ),
                    ],
                  ),
                  6.ESH(),
                  CustomTextR(
                    service.description!,
                    fontSize: 14.sp,
                  ),
                ],
              ),
            ),

          // Social Media Section
          if (_hasSocialMedia())
            Container(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.public_outlined,
                        size: 20.sp,
                        color: AppColors.main,
                      ),
                      6.ESW(),
                      CustomTextL(
                        'social_media_links',
                        fontSize: 14.sp,
                        fontWeight: FW.bold,
                        color: Colors.grey[800],
                      ),
                    ],
                  ),
                  12.ESH(),
                  Row(
                    children: [
                      // Facebook
                      if (service.facebookUrl != null &&
                          service.facebookUrl!.isNotEmpty)
                        _buildSocialMediaIcon(
                          icon: 'Facebook',
                          url: service.facebookUrl!,
                          color: const Color(0xFF1877F2),
                        ),

                      // Instagram
                      if (service.instagramUrl != null &&
                          service.instagramUrl!.isNotEmpty)
                        _buildSocialMediaIcon(
                          icon: 'Instagram',
                          url: service.instagramUrl!,
                          color: const Color(0xFFE4405F),
                        ),

                      // TikTok
                      if (service.tikTokUrl != null &&
                          service.tikTokUrl!.isNotEmpty)
                        _buildSocialMediaIcon(
                          icon: 'Tiktok',
                          url: service.tikTokUrl!,
                          color: const Color(0xFF000000),
                        ),

                      // YouTube
                      if (service.youTubeUrl != null &&
                          service.youTubeUrl!.isNotEmpty)
                        _buildSocialMediaIcon(
                          icon: 'Youtube',
                          url: service.youTubeUrl!,
                          color: const Color(0xFFFF0000),
                        ),
                    ],
                  ),
                ],
              ),
            ),

          // discounts section
          if (service.discounts.isNotEmpty)
            Container(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.discount_outlined,
                        size: 20.sp,
                        color: AppColors.main,
                      ),
                      6.ESW(),
                      CustomTextL(
                        'Discounts',
                        fontSize: 14.sp,
                        fontWeight: FW.bold,
                        color: Colors.grey[800],
                      ),
                    ],
                  ),
                  6.ESH(),
                  ...service.discounts.entries.map(
                    (e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: CustomTextL(e.key, fontSize: 14.sp)),
                        10.ESW(),
                        if (e.value == true || e.value == 'true')
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 4.h,
                            ),
                            padding: EdgeInsets.all(4.sp),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                            child: Center(
                                child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20.sp,
                            )),
                          )
                        else
                          CustomTextR(
                            '${e.value}',
                            fontSize: 14.sp,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          // Branches Section
          Container(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 20.sp,
                      color: AppColors.main,
                    ),
                    6.ESW(),
                    CustomTextL(
                      'branches'.tr,
                      fontSize: 14.sp,
                      fontWeight: FW.bold,
                      color: Colors.grey[800],
                    ),
                    6.ESW(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.main,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: CustomTextR(
                        '${service.branches.length}',
                        fontSize: 13.sp,
                        color: Colors.white,
                        fontWeight: FW.bold,
                      ),
                    ),
                  ],
                ),
                12.ESH(),

                // Display first 2 branches
                ...service.branches.take(2).map((branch) {
                  return _buildBranchItem(branch, isArabic);
                }).toList(),

                // Show more branches indicator
                if (service.branches.length > 2) ...[
                  8.ESH(),
                  InkWell(
                    onTap: () => _showAllBranches(context, service.branches),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.main.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextL(
                            'View_all_branches',
                            fontSize: 14.sp,
                            color: AppColors.main,
                            fontWeight: FW.medium,
                          ),
                          4.ESW(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12.sp,
                            color: AppColors.main,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Divider(height: 1, color: Colors.grey[200]),
          ),

          // Action Buttons (Conditional based on status)
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildStatusHeader() {
    if (service.status == ServiceStatus.pending) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: service.status.color.withOpacity(0.1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Row(
          children: [
            Icon(
              service.status.icon,
              size: 18.sp,
              color: service.status.color,
            ),
            8.ESW(),
            Expanded(
              child: CustomTextL(
                service.status.translationKey.tr,
                fontSize: 14.sp,
                fontWeight: FW.medium,
                color: service.status.color,
              ),
            ),
          ],
        ),
      );
    } else if (service.status == ServiceStatus.approved) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: service.status.color.withOpacity(0.1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Row(
          children: [
            Icon(
              service.status.icon,
              size: 18.sp,
              color: service.status.color,
            ),
            8.ESW(),
            Expanded(
              child: CustomTextL(
                service.status.translationKey.tr,
                fontSize: 14.sp,
                fontWeight: FW.medium,
                color: service.status.color,
              ),
            ),
          ],
        ),
      );
    } else if (service.status == ServiceStatus.rejected) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: service.status.color.withOpacity(0.1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Row(
          children: [
            Icon(
              service.status.icon,
              size: 18.sp,
              color: service.status.color,
            ),
            8.ESW(),
            Expanded(
              child: CustomTextL(
                service.status.translationKey.tr,
                fontSize: 14.sp,
                fontWeight: FW.medium,
                color: service.status.color,
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  List<Color> _getHeaderGradientColors() {
    switch (service.status) {
      case ServiceStatus.pending:
        return [
          Colors.orange.withOpacity(0.07),
          Colors.orange.withOpacity(0.02)
        ];
      case ServiceStatus.approved:
        return [Colors.green.withOpacity(0.05), Colors.green.withOpacity(0.02)];
      case ServiceStatus.rejected:
        return [Colors.red.withOpacity(0.05), Colors.red.withOpacity(0.02)];
      default:
        return [
          AppColors.main.withOpacity(0.1),
          AppColors.main.withOpacity(0.05)
        ];
    }
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: AppColors.main.withOpacity(0.1),
      child: Center(
        child: Icon(
          Icons.medical_services_outlined,
          size: 35.sp,
          color: AppColors.main,
        ),
      ),
    );
  }

  Widget _buildBranchItem(BranchModel branch, bool isArabic) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey[200]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location with clickable URL
          Row(
            children: [
              Icon(
                Icons.location_city,
                size: 20.sp,
                color: AppColors.main,
              ),
              6.ESW(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextR(
                          '${branch.governorate.tr} - ${branch.city.tr}',
                          fontSize: 14.sp,
                          fontWeight: FW.medium,
                          color: Colors.grey[800],
                          maxLines: 2,
                          isOverFlow: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          6.ESH(),

          // Address
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Icon(
                  Icons.home_outlined,
                  size: 20.sp,
                  color: Colors.grey[600],
                ),
              ),
              6.ESW(),
              Expanded(
                child: CustomTextR(
                  branch.address.isNotEmpty
                      ? branch.address
                      : 'no_address_available'.tr,
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                  maxLines: 3,
                  isOverFlow: true,
                ),
              ),
            ],
          ),
          8.ESH(),
          // Location Button (only if URL exists)
          if (branch.locationUrl.isNotEmpty) ...[
            InkWell(
              onTap: () => _launchLocationUrl(branch.locationUrl),
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.main.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 18.sp,
                      color: AppColors.main,
                    ),
                    4.ESW(),
                    CustomTextL(
                      'view_location'.tr,
                      fontSize: 16.sp,
                      color: AppColors.main,
                      fontWeight: FW.medium,
                    ),
                  ],
                ),
              ),
            ),
            8.ESW(),
          ],
          8.ESH(),
          // Contact Info
          ...[
            Row(
              children: [
                // Phone
                ...[
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          size: 18.sp,
                          color: Colors.grey[600],
                        ),
                        6.ESW(),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _launchPhone(branch.phoneNumber),
                            child: CustomTextR(
                              branch.phoneNumber,
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                              maxLines: 1,
                              isOverFlow: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                12.ESW(),

                // WhatsApp
                Expanded(
                  child: Row(
                    children: [
                      IconSvg(
                        'Whatsapp',
                        size: 18.sp,
                        boxFit: BoxFit.contain,
                        color: Colors.green[600],
                      ),
                      6.ESW(),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _launchWhatsApp(branch.whatsapp),
                          child: CustomTextR(
                            branch.whatsapp,
                            fontSize: 14.sp,
                            color: Colors.green[600],
                            maxLines: 1,
                            isOverFlow: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            8.ESH(),
          ],

          // Working Hours and Location Button
          Row(
            children: [
              // Working Hours
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 18.sp,
                      color: AppColors.main,
                    ),
                    6.ESW(),
                    CustomTextL(
                      'working_hours'.tr,
                      fontSize: 13.sp,
                      fontWeight: FW.medium,
                      color: Colors.grey[800],
                    ),
                  ],
                ),
              ),

              // View All Hours Button
              InkWell(
                onTap: () => _showBranchWorkingHours(branch, {
                  'saturday': 'saturday'.tr,
                  'sunday': 'sunday'.tr,
                  'monday': 'monday'.tr,
                  'tuesday': 'tuesday'.tr,
                  'wednesday': 'wednesday'.tr,
                  'thursday': 'thursday'.tr,
                  'friday': 'friday'.tr,
                }),
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppColors.main.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextL(
                        'view_all'.tr,
                        fontSize: 12.sp,
                        color: AppColors.main,
                        fontWeight: FW.medium,
                      ),
                      4.ESW(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 10.sp,
                        color: AppColors.main,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showBranchWorkingHours(BranchModel branch, Map<String, String> days) {
    final workingHours = branch.workingHours;
    final bool isArabic = Get.locale?.languageCode == 'ar';

    Get.bottomSheet(
      Container(
        height: Get.height * 0.75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r),
            topRight: Radius.circular(25.r),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Drag indicator
            Container(
              width: 50.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            16.ESH(),

            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.access_time, color: AppColors.main, size: 22.sp),
                6.ESW(),
                CustomTextL(
                  'working_hours'.tr,
                  fontSize: 18.sp,
                  fontWeight: FW.bold,
                ),
              ],
            ),
            8.ESH(),

            // Location
            CustomTextR(
              '${branch.governorate.tr} - ${branch.city.tr}',
              fontSize: 14.sp,
              color: Colors.grey[600],
              textAlign: TextAlign.center,
            ),

            // Contact info in the header
            if (branch.phoneNumber.isNotEmpty ||
                branch.whatsapp.isNotEmpty) ...[
              8.ESH(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (branch.phoneNumber.isNotEmpty) ...[
                    Icon(Icons.phone, size: 16.sp, color: Colors.grey[600]),
                    4.ESW(),
                    CustomTextR(
                      branch.phoneNumber,
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ],
                  if (branch.phoneNumber.isNotEmpty &&
                      branch.whatsapp.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Container(
                        width: 4.w,
                        height: 4.w,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  if (branch.whatsapp.isNotEmpty) ...[
                    IconSvg(
                      'Whatsapp',
                      size: 16.sp,
                      color: Colors.green[600],
                    ),
                    4.ESW(),
                    CustomTextR(
                      branch.whatsapp,
                      fontSize: 12.sp,
                      color: Colors.green[600],
                    ),
                  ],
                ],
              ),
            ],

            16.ESH(),

            // Column Headers
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                children: [
                  20.ESW(),
                  Expanded(
                    child: CustomTextL(
                      'Day'.tr,
                      fontSize: 13.sp,
                      color: Colors.grey[600],
                      fontWeight: FW.bold,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomTextL(
                          'from'.tr,
                          fontSize: 13.sp,
                          color: Colors.grey[600],
                          fontWeight: FW.bold,
                          textAlign: TextAlign.center,
                        ),
                        70.ESW(),
                        CustomTextL(
                          'to'.tr,
                          fontSize: 13.sp,
                          color: Colors.grey[600],
                          fontWeight: FW.bold,
                          textAlign: TextAlign.center,
                        ),
                        30.ESW(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Divider
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Divider(height: 1, color: Colors.grey[300]),
            ),

            8.ESH(),

            // Working hours list
            Expanded(
              child: ListView.builder(
                shrinkWrap: false,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: days.length,
                itemBuilder: (context, index) {
                  final dayKey = days.keys.elementAt(index);
                  final dayLabel = days.values.elementAt(index);
                  // Get hours directly from backend without formatting
                  final hours =
                      workingHours[dayKey] ?? (isArabic ? 'مغلق' : 'Closed');
                  final isClosed = _isClosed(hours);

                  // Split the times
                  final timeParts = _splitWorkingHours(hours);

                  return Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: isClosed
                          ? Colors.grey[50]
                          : Colors.green[50]!.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color:
                            isClosed ? Colors.grey[200]! : Colors.green[100]!,
                      ),
                    ),
                    child: Row(
                      children: [
                        CustomTextR(
                          dayLabel,
                          fontSize: 14.sp,
                          fontWeight: FW.medium,
                          color: Colors.grey[800],
                        ),
                        Expanded(
                          child: isClosed
                              ? CustomTextL(
                                  timeParts['closed']!,
                                  fontSize: 14.sp,
                                  color: Colors.red[600]!,
                                  fontWeight: FW.medium,
                                  textAlign: TextAlign.end,
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CustomTextR(
                                      timeParts['from']!,
                                      fontSize: 14.sp,
                                      color: Colors.green[700]!,
                                      fontWeight: FW.medium,
                                    ),
                                    30.ESW(),
                                    CustomTextR(
                                      timeParts['to']!,
                                      fontSize: 14.sp,
                                      color: Colors.green[700]!,
                                      fontWeight: FW.medium,
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            20.ESH(),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  // Split working hours into from and to times
  Map<String, String> _splitWorkingHours(String hours) {
    if (_isClosed(hours)) {
      final bool isArabic = Get.locale?.languageCode == 'ar';
      return {
        'closed': hours.isEmpty ? (isArabic ? 'مغلق' : 'Closed') : hours,
        'from': '',
        'to': '',
      };
    }

    // Split by dash or hyphen
    final parts = hours.split(RegExp(r'\s*[-–—]\s*'));

    if (parts.length >= 2) {
      return {
        'from': parts[0].trim(),
        'to': parts[1].trim(),
        'closed': '',
      };
    }

    // If no dash found, return the whole string as is
    return {
      'from': hours.trim(),
      'to': '',
      'closed': '',
    };
  }

// Simplified closed check
  bool _isClosed(String hours) {
    final closedIndicators = ['مغلق', 'closed'];

    return hours.isEmpty ||
        closedIndicators.any((indicator) =>
            hours.toLowerCase().contains(indicator.toLowerCase()));
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Row(
        children: [
          // Edit Button (allowed for ALL statuses)
          Expanded(
            child: _buildActionButton(
              icon: Icons.edit_outlined,
              label: 'edit',
              color: AppColors.main,
              onTap: onEdit,
            ),
          ),
          12.ESW(),
          Expanded(
            child: _buildActionButton(
              icon: Icons.add_location_outlined,
              label: 'add_branch',
              color: Colors.green[600]!,
              onTap: () => _addBranchToService(context),
            ),
          ),
          12.ESW(),
          // Delete Button
          Expanded(
            child: _buildActionButton(
              icon: Icons.delete_outline,
              label: 'delete',
              color: Colors.red[600]!,
              onTap: () => _showDeleteConfirmation(context, onDelete),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: color.withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18.sp, color: color),
            6.ESW(),
            CustomTextL(
              label.tr,
              fontSize: 13.sp,
              fontWeight: FW.medium,
              color: color,
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, VoidCallback onConfirm) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Container(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.delete_outline,
                  size: 30.sp,
                  color: Colors.red[600],
                ),
              ),
              20.ESH(),
              CustomTextL(
                'delete_service'.tr,
                fontSize: 18.sp,
                fontWeight: FW.bold,
                color: Colors.grey[900],
              ),
              12.ESH(),
              CustomTextR(
                'delete_service_confirmation'.tr,
                fontSize: 14.sp,
                color: Colors.grey[600],
                textAlign: TextAlign.center,
              ),
              24.ESH(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.grey[700],
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: CustomTextL(
                        'cancel'.tr,
                        fontSize: 14.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  12.ESW(),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        onConfirm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[600],
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: CustomTextL(
                        'delete'.tr,
                        fontSize: 14.sp,
                        color: Colors.white,
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

  void _showAllBranches(BuildContext context, List<BranchModel> branches) {
    final bool isArabic = Get.locale?.languageCode == 'ar';

    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r),
            topRight: Radius.circular(25.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            12.ESH(),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            20.ESH(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColors.main,
                    size: 24.sp,
                  ),
                  8.ESW(),
                  CustomTextL(
                    'all_branches'.tr,
                    fontSize: 18.sp,
                    fontWeight: FW.bold,
                  ),
                  4.ESW(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.main,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: CustomTextR(
                      '${branches.length}',
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FW.bold,
                    ),
                  ),
                ],
              ),
            ),
            20.ESH(),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: branches.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: _buildBranchItem(branches[index], isArabic),
                  );
                },
              ),
            ),
            20.ESH(),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  bool _hasSocialMedia() {
    return (service.facebookUrl != null && service.facebookUrl!.isNotEmpty) ||
        (service.instagramUrl != null && service.instagramUrl!.isNotEmpty) ||
        (service.tikTokUrl != null && service.tikTokUrl!.isNotEmpty) ||
        (service.youTubeUrl != null && service.youTubeUrl!.isNotEmpty);
  }

  Widget _buildSocialMediaIcon({
    required String icon,
    required String url,
    required Color color,
  }) {
    return InkWell(
      onTap: () => _launchSocialMedia(url),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        margin: EdgeInsetsDirectional.only(start: 12.w),
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Center(
          child: IconSvg(
            icon,
            size: 24.sp,
            color: color,
            boxFit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Future<void> _launchSocialMedia(String url) async {
    try {
      // Ensure the URL has a proper scheme
      String formattedUrl = url;
      if (!formattedUrl.startsWith('http://') &&
          !formattedUrl.startsWith('https://')) {
        formattedUrl = 'https://$formattedUrl';
      }

      if (await canLaunchUrl(Uri.parse(formattedUrl))) {
        await launchUrl(Uri.parse(formattedUrl));
      } else {
        Get.snackbar(
          'error'.tr,
          'cannot_open_link'.tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'cannot_open_link'.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _launchLocationUrl(String url) async {
    try {
      // Ensure the URL has a proper scheme
      String formattedUrl = url;
      if (!formattedUrl.startsWith('http://') &&
          !formattedUrl.startsWith('https://')) {
        formattedUrl = 'https://$formattedUrl';
      }

      if (await canLaunchUrl(Uri.parse(formattedUrl))) {
        await launchUrl(Uri.parse(formattedUrl));
      } else {
        Get.snackbar(
          'error'.tr,
          'cannot_open_location'.tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'cannot_open_location'.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _launchPhone(String phoneNumber) async {
    try {
      final url = 'tel:$phoneNumber';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        Get.snackbar(
          'error'.tr,
          'cannot_make_call'.tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'cannot_make_call'.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _launchWhatsApp(String whatsappNumber) async {
    try {
      // Clean the phone number (remove any non-digit characters except +)
      String cleanedNumber = whatsappNumber.replaceAll(RegExp(r'[^\d+]'), '');

      // Add +20 country code if not already present
      if (!cleanedNumber.startsWith('+')) {
        // Remove leading zeros if present
        cleanedNumber = cleanedNumber.replaceFirst(RegExp(r'^0+'), '');
        // Add +20 for Egyptian numbers
        cleanedNumber = '+20$cleanedNumber';
      }

      final url = 'https://wa.me/$cleanedNumber';

      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        Get.snackbar(
          'error'.tr,
          'cannot_open_whatsapp'.tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'cannot_open_whatsapp'.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _addBranchToService(BuildContext context) {
    // Show confirmation dialog
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Container(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add_location_outlined,
                  size: 30.sp,
                  color: Colors.green[600],
                ),
              ),
              20.ESH(),
              CustomTextL(
                'add_new_branch'.tr,
                fontSize: 18.sp,
                fontWeight: FW.bold,
                color: Colors.grey[900],
              ),
              12.ESH(),
              CustomTextR(
                'add_branch_confirmation'.tr,
                fontSize: 14.sp,
                color: Colors.grey[600],
                textAlign: TextAlign.center,
              ),
              24.ESH(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.grey[700],
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: CustomTextL(
                        'cancel'.tr,
                        fontSize: 14.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  12.ESW(),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        _navigateToAddBranch();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: CustomTextL(
                        'add_branch'.tr,
                        fontSize: 14.sp,
                        color: Colors.white,
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

  void _navigateToAddBranch() {
    // Navigate to the add service screen with step 3 pre-selected
    Get.to(
      () => AddServiceScreen(serviceToEdit: service),
      arguments: {'initialStep': 2}, // Step 3 is index 2 (0-based)
    )?.then((_) {
      // Refresh services list when returning
      Get.find<ServicesController>().fetchServices();
    });
  }
}
