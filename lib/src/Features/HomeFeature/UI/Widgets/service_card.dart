import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

// Enhanced Service Model with Status
class ServiceModel {
  final String id;
  final String serviceName;
  final String? serviceType;
  final String? specialization;
  final String? imageUrl;
  final String discount;
  final List<BranchModel> branches;
  final ServiceStatus status;
  final DateTime? createdAt;
  final DateTime? approvedAt;
  final String? rejectionReason;

  ServiceModel({
    required this.id,
    required this.serviceName,
    this.serviceType,
    this.specialization,
    this.imageUrl,
    required this.discount,
    required this.branches,
    required this.status,
    this.createdAt,
    this.approvedAt,
    this.rejectionReason,
  });
}

// Service Status Enum
enum ServiceStatus {
  pending('pending', 'under_review', Colors.orange, Icons.hourglass_empty),
  approved('approved', 'approved', Colors.green, Icons.verified),
  rejected('rejected', 'rejected', Colors.red, Icons.cancel);

  final String value;
  final String translationKey;
  final Color color;
  final IconData icon;

  const ServiceStatus(this.value, this.translationKey, this.color, this.icon);
}

// Enhanced Branch Model
class BranchModel {
  final String governorate;
  final String city;
  final String address;
  final String phone;
  final String whatsapp;
  final Map<String, String> workingHours;

  BranchModel({
    required this.governorate,
    required this.city,
    required this.address,
    required this.phone,
    required this.whatsapp,
    required this.workingHours,
  });

  // Get working hours for a specific day
  String getWorkingHoursForDay(String dayKey) {
    final hours = workingHours[dayKey] ?? '';
    if (hours.isEmpty || hours.toLowerCase() == 'closed') {
      return 'closed'.tr;
    }
    return hours;
  }

  // Get today's working hours
  String get todaysWorkingHours {
    final today = _getTodayKey();
    return getWorkingHoursForDay(today);
  }

  String _getTodayKey() {
    final now = DateTime.now();
    final days = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday'
    ];
    return days[now.weekday - 1];
  }
}

// Enhanced Service Card Widget
class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onViewDetails;

  const ServiceCard({
    super.key,
    required this.service,
    required this.onEdit,
    required this.onDelete,
    this.onViewDetails,
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
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                    service.status == ServiceStatus.pending ? 0 : 20.r),
                topRight: Radius.circular(
                    service.status == ServiceStatus.pending ? 0 : 20.r),
              ),
            ),
            child: Row(
              children: [
                // Service Image with Status Indicator
                Stack(
                  children: [
                    Container(
                      width: 70.w,
                      height: 70.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
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
                        borderRadius: BorderRadius.circular(12.r),
                        child: service.imageUrl != null
                            ? Image.network(
                                service.imageUrl!,
                                fit: BoxFit.cover,
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
                          if (service.discount.isNotEmpty) ...[
                            8.ESW(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(6.r),
                                border: Border.all(
                                  color: Colors.green[200]!,
                                ),
                              ),
                              child: CustomTextR(
                                '${service.discount}%',
                                fontSize: 12.sp,
                                color: Colors.green[800],
                                fontWeight: FW.bold,
                              ),
                            ),
                          ],
                        ],
                      ),
                      6.ESH(),

                      if (service.specialization != null) ...[
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.main.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: CustomTextR(
                                service.specialization!,
                                fontSize: 11.sp,
                                color: AppColors.main,
                                fontWeight: FW.medium,
                              ),
                            ),
                          ],
                        ),
                        6.ESH(),
                      ],

                      // Service Type
                      if (service.serviceType != null)
                        CustomTextR(
                          service.serviceType!,
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),

                      4.ESH(),

                      // Approval Date
                      if (service.status == ServiceStatus.approved &&
                          service.approvedAt != null)
                        Row(
                          children: [
                            Icon(
                              Icons.verified_outlined,
                              size: 12.sp,
                              color: Colors.green[600],
                            ),
                            4.ESW(),
                            CustomTextR(
                              'approved_on'.trParams(
                                  {'date': _formatDate(service.approvedAt!)}),
                              fontSize: 11.sp,
                              color: Colors.green[600],
                            ),
                          ],
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
                      size: 18.sp,
                      color: AppColors.main,
                    ),
                    6.ESW(),
                    CustomTextL(
                      'branches'.tr,
                      fontSize: 14.sp,
                      fontWeight: FW.bold,
                      color: Colors.grey[800],
                    ),
                    4.ESW(),
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
                        fontSize: 11.sp,
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
                          CustomTextR(
                            '${'view'.tr} ${service.branches.length - 2} ${'more_branches'.tr}',
                            fontSize: 12.sp,
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
            Icon(
              Icons.hourglass_empty,
              size: 16.sp,
              color: service.status.color,
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
          Colors.orange.withOpacity(0.05),
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
    final days = {
      'saturday': 'saturday'.tr,
      'sunday': 'sunday'.tr,
      'monday': 'monday'.tr,
      'tuesday': 'tuesday'.tr,
      'wednesday': 'wednesday'.tr,
      'thursday': 'thursday'.tr,
      'friday': 'friday'.tr,
    };

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
          // Location
          Row(
            children: [
              Icon(
                Icons.location_city,
                size: 14.sp,
                color: AppColors.main,
              ),
              6.ESW(),
              Expanded(
                child: CustomTextR(
                  '${branch.governorate} - ${branch.city}',
                  fontSize: 13.sp,
                  fontWeight: FW.medium,
                  color: Colors.grey[800],
                  maxLines: 1,
                  isOverFlow: true,
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
                  size: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
              6.ESW(),
              Expanded(
                child: CustomTextR(
                  branch.address,
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                  maxLines: 2,
                  isOverFlow: true,
                ),
              ),
            ],
          ),
          8.ESH(),

          // Contact Info
          Row(
            children: [
              // Phone
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      size: 14.sp,
                      color: Colors.grey[600],
                    ),
                    4.ESW(),
                    Expanded(
                      child: CustomTextR(
                        branch.phone,
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                        maxLines: 1,
                        isOverFlow: true,
                      ),
                    ),
                  ],
                ),
              ),

              8.ESW(),

              // WhatsApp (if available)
              if (branch.whatsapp.isNotEmpty)
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.abc,
                        size: 14.sp,
                        color: Colors.green[600],
                      ),
                      4.ESW(),
                      Expanded(
                        child: CustomTextR(
                          branch.whatsapp,
                          fontSize: 12.sp,
                          color: Colors.green[600],
                          maxLines: 1,
                          isOverFlow: true,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          8.ESH(),

          // Working Hours Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14.sp,
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
              6.ESH(),

              // Today's hours
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.today,
                      size: 12.sp,
                      color: AppColors.main,
                    ),
                    6.ESW(),
                    CustomTextR(
                      'today'.tr,
                      fontSize: 11.sp,
                      fontWeight: FW.medium,
                      color: Colors.grey[700],
                    ),
                    8.ESW(),
                    Expanded(
                      child: CustomTextR(
                        branch.todaysWorkingHours,
                        fontSize: 11.sp,
                        color: Colors.grey[600],
                        maxLines: 1,
                        isOverFlow: true,
                      ),
                    ),
                  ],
                ),
              ),

              8.ESH(),

              // Show all days working hours in a compact way
              InkWell(
                onTap: () => _showBranchWorkingHours(branch, days),
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
                      CustomTextR(
                        'view_all_hours'.tr,
                        fontSize: 11.sp,
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
                    Icons.access_time,
                    color: AppColors.main,
                    size: 24.sp,
                  ),
                  8.ESW(),
                  CustomTextL(
                    'working_hours'.tr,
                    fontSize: 18.sp,
                    fontWeight: FW.bold,
                  ),
                ],
              ),
            ),
            16.ESH(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomTextR(
                '${branch.governorate} - ${branch.city}',
                fontSize: 14.sp,
                color: Colors.grey[600],
                textAlign: TextAlign.center,
              ),
            ),
            20.ESH(),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: days.length,
                itemBuilder: (context, index) {
                  final dayKey = days.keys.elementAt(index);
                  final dayLabel = days.values.elementAt(index);
                  final hours = branch.getWorkingHoursForDay(dayKey);

                  return Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomTextR(
                            dayLabel,
                            fontSize: 13.sp,
                            fontWeight: FW.medium,
                            color: Colors.grey[800],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: CustomTextR(
                            hours,
                            fontSize: 13.sp,
                            color: hours.toLowerCase().contains('closed')
                                ? Colors.red[600]!
                                : Colors.green[600]!,
                            fontWeight: FW.medium,
                            textAlign: TextAlign.end,
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

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Row(
        children: [
          // View Details Button (for approved services)
          if (service.status == ServiceStatus.approved &&
              onViewDetails != null) ...[
            Expanded(
              child: _buildActionButton(
                icon: Icons.remove_red_eye_outlined,
                label: 'view_details',
                color: Colors.blue[600]!,
                onTap: onViewDetails!,
              ),
            ),
            12.ESW(),
          ],

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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
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
}
