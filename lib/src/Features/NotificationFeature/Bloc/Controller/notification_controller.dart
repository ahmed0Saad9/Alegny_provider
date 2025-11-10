import 'package:Alegny_provider/src/Features/NotificationFeature/Bloc/Model/notification_model.dart';
import 'package:Alegny_provider/src/Features/NotificationFeature/Bloc/Repo/notification_repo.dart';
import 'package:Alegny_provider/src/core/services/Base/base_controller.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

class NotificationsController extends BaseController<NotificationsRepo> {
  @override
  NotificationsRepo get repository => sl<NotificationsRepo>();

  var notifications = <NotificationModel>[].obs;
  var isLoading = false.obs;
  var hasUnreadNotifications = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    try {
      isLoading.value = true;
      final result = await repository.getNotifications();

      result.when(
        success: (List<NotificationModel> data) {
          notifications.value = data;
          _updateUnreadStatus();
        },
        failure: (error) {
          Get.snackbar(
            'error'.tr,
            NetworkExceptions.getErrorMessage(error),
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      final result = await repository.markAsRead(notificationId);

      result.when(
        success: (_) {
          // Update local state immediately
          _updateNotificationReadStatus(notificationId);
          _updateUnreadStatus();

          // Show success message
          Get.snackbar(
            'success'.tr,
            'notification_marked_read'.tr,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        },
        failure: (error) {
          Get.snackbar(
            'error'.tr,
            NetworkExceptions.getErrorMessage(error),
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        },
      );
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'Failed to mark notification as read',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // New method to update notification status locally
  void _updateNotificationReadStatus(String notificationId) {
    final index = notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      notifications[index] = notifications[index].copyWith(isRead: true);
      update(); // Force UI update
    }
  }

  // Method to get notification by ID (for detail screen)
  NotificationModel? getNotificationById(String id) {
    try {
      return notifications.firstWhere((notification) => notification.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> markAllAsRead() async {
    try {
      final unreadNotifications =
          notifications.where((n) => !n.isRead).toList();

      for (final notification in unreadNotifications) {
        await markAsRead(notification.id);
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'Failed to mark all as read',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _updateUnreadStatus() {
    hasUnreadNotifications.value =
        notifications.any((notification) => !notification.isRead);
  }

  List<NotificationModel> get unreadNotifications =>
      notifications.where((notification) => !notification.isRead).toList();

  List<NotificationModel> get readNotifications =>
      notifications.where((notification) => notification.isRead).toList();
}
