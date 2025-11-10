import 'package:Alegny_provider/src/Features/NotificationFeature/Bloc/Model/notification_model.dart';
import 'package:Alegny_provider/src/core/constants/api_key.dart';
import 'package:Alegny_provider/src/core/services/Network/api_result.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/Network/network_services.dart';
import 'package:get/instance_manager.dart';

class NotificationsRepo with ApiKey {
  final NetworkService _networkService = Get.find();

  Future<ApiResult<List<NotificationModel>>> getNotifications() async {
    try {
      final response = await _networkService.get(
        url: uRLGetNotifications,
        auth: true,
      );

      if (response.data is List) {
        final notifications = (response.data as List)
            .map((item) => NotificationModel.fromJson(item))
            .toList();
        return ApiResult.success(notifications);
      } else {
        return const ApiResult.failure(
            NetworkExceptions.defaultError("Invalid response format"));
      }
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<void>> markAsRead(String notificationId) async {
    try {
      await _networkService.post(
        url: uRLReadNotifications(notificationId: notificationId),
        auth: true, // ADD THIS LINE - This was missing!
      );
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
