import 'package:Alegny_provider/src/Features/NotificationFeature/Bloc/Model/notification_model.dart';
import 'package:Alegny_provider/src/Features/NotificationFeature/Bloc/Controller/notification_controller.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Appbars/app_bars.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/base_scaffold.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class NotificationDetailScreen extends StatefulWidget {
  final String notificationId;

  const NotificationDetailScreen({
    super.key,
    required this.notificationId,
  });

  @override
  State<NotificationDetailScreen> createState() =>
      _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  final NotificationsController controller =
      Get.find<NotificationsController>();

  @override
  void initState() {
    super.initState();
    // Mark as read when screen opens
    _markAsReadIfNeeded();
  }

  void _markAsReadIfNeeded() {
    final notification = controller.getNotificationById(widget.notificationId);
    if (notification != null && !notification.isRead) {
      controller.markAsRead(widget.notificationId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationsController>(
      builder: (controller) {
        final notification =
            controller.getNotificationById(widget.notificationId);

        if (notification == null) {
          return BaseScaffold(
            appBar: AppBars.appBarBack(title: 'notification_details'.tr),
            body: Center(
              child: CustomTextL(
                'notification_not_found'.tr,
                fontSize: 16.sp,
                color: Colors.grey,
              ),
            ),
          );
        }

        return BaseScaffold(
          appBar: AppBars.appBarBack(title: 'notification_details'.tr),
          body: SingleChildScrollView(
            padding: AppPadding.paddingScreenSH36,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                40.ESH(),

                // Title Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.main.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.main.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Status Indicator
                          Container(
                            width: 10.w,
                            height: 10.w,
                            margin: EdgeInsets.only(left: 8.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: notification.isRead
                                  ? Colors.grey
                                  : AppColors.main,
                            ),
                          ),
                          8.ESW(),
                          CustomTextL(
                            notification.isRead ? 'read'.tr : 'unread'.tr,
                            fontSize: 12.sp,
                            color: notification.isRead
                                ? Colors.grey
                                : AppColors.main,
                          ),
                          const Spacer(),
                          // Date
                          CustomTextL(
                            _formatDetailedDate(notification.dateSent),
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      12.ESH(),
                      // Title
                      CustomTextL(
                        notification.title,
                        fontSize: 20.sp,
                        fontWeight: FW.bold,
                        color: AppColors.titleGray7A,
                      ),
                    ],
                  ),
                ),

                32.ESH(),

                // Message Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextL(
                        'message'.tr,
                        fontSize: 16.sp,
                        color: AppColors.main,
                      ),
                      16.ESH(),
                      CustomTextL(
                        notification.message,
                        fontSize: 16.sp,
                        color: AppColors.titleGray7A,
                      ),
                    ],
                  ),
                ),

                32.ESH(),

                // Additional Info Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextL(
                        'notification_info',
                        fontSize: 14.sp,
                        color: AppColors.titleGray7A,
                      ),
                      12.ESH(),
                      _buildInfoRow('sent_date'.tr,
                          _formatFullDate(notification.dateSent)),
                      // _buildInfoRow('status'.tr,
                      //     notification.isRead ? 'read'.tr : 'unread'.tr),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Mark as Read Button (only if unread)
          bottomNavigationBar: !notification.isRead
              ? Container(
                  padding: EdgeInsets.all(16.w),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.markAsRead(notification.id);
                      setState(() {}); // Force UI update
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.main,
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: CustomTextL(
                      'mark_as_read'.tr,
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: CustomTextL(
              label,
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
          ),
          8.ESW(),
          Expanded(
            flex: 3,
            child: CustomTextL(
              value,
              fontSize: 14.sp,
              color: AppColors.titleGray7A,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDetailedDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'just_now'.tr;
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} ${'minutes_ago'.tr}';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} ${'hours_ago'.tr}';
    } else {
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    }
  }

  String _formatFullDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
