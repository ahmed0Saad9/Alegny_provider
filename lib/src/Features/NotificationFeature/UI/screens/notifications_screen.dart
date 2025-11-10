import 'package:Alegny_provider/src/Features/NotificationFeature/Bloc/Controller/notification_controller.dart';
import 'package:Alegny_provider/src/Features/NotificationFeature/Bloc/Model/notification_model.dart';
import 'package:Alegny_provider/src/Features/NotificationFeature/UI/screens/notification_details_screen.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Appbars/app_bars.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/base_scaffold.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBars.appBarBack(title: 'notifications'.tr),
      body: GetBuilder<NotificationsController>(
        init: NotificationsController(),
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.notifications.isEmpty) {
            return _buildEmptyState();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Notifications List
              Expanded(
                child: _buildNotificationsList(controller),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNotificationsList(NotificationsController controller) {
    return RefreshIndicator(
      onRefresh: () => controller.loadNotifications(),
      child: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: controller.notifications.length,
        separatorBuilder: (context, index) => 16.ESH(),
        itemBuilder: (context, index) {
          final notification = controller.notifications[index];
          return _buildNotificationItem(notification, controller);
        },
      ),
    );
  }

  Widget _buildNotificationItem(
      NotificationModel notification, NotificationsController controller) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          color: notification.isRead ? AppColors.titleGray95 : AppColors.main,
          borderRadius: BorderRadius.circular(12.r),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Icon(
          notification.isRead
              ? Icons.mark_email_unread_outlined
              : Icons.mark_email_read_outlined,
          color: AppColors.main,
          size: 24.w,
        ),
      ),
      onDismissed: (direction) {
        if (!notification.isRead) {
          controller.markAsRead(notification.id);
        }
      },
      child: InkWell(
        onTap: () {
          // Navigate to detail screen with notification ID
          Get.to(() => NotificationDetailScreen(
                notificationId: notification.id,
              ));
        },
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: notification.isRead
                  ? Colors.grey
                  : AppColors.main.withOpacity(0.3),
              width: notification.isRead ? 1 : 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    CustomTextL(
                      notification.title,
                      fontSize: 16.sp,
                      color: AppColors.titleGray7A,
                    ),

                    8.ESH(),

                    // Message
                    CustomTextL(
                      notification.message,
                      fontSize: 14.sp,
                      color: AppColors.titleGray95,
                      maxLines: 3,
                      isOverFlow: true,
                    ),

                    8.ESH(),

                    // Date
                    CustomTextL(
                      _formatDate(notification.dateSent),
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),

              // Status Indicator
              Container(
                width: 8.w,
                height: 8.w,
                margin: EdgeInsets.only(top: 4.h, right: 12.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: notification.isRead ? Colors.grey : AppColors.main,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none_outlined,
            size: 80.w,
            color: Colors.grey.shade400,
          ),
          20.ESH(),
          CustomTextL(
            'no_notifications',
            fontSize: 18.sp,
            color: Colors.grey.shade600,
          ),
          8.ESH(),
          CustomTextL(
            'no_notifications_subtitle',
            fontSize: 14.sp,
            color: Colors.grey.shade500,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'just_now'.tr;
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} ${'minutes_ago'.tr}';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} ${'hours_ago'.tr}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${'days_ago'.tr}';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
