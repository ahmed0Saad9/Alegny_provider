import 'package:Alegny_provider/src/core/constants/api_key.dart';
import 'package:Alegny_provider/src/core/services/Network/api_result.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/Network/network_services.dart';
import 'package:dio/dio.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/instance_manager.dart';

class BRepository with ApiKey {
  final NetworkService _networkService = Get.find();

  // final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<ApiResult<Response>> b() async {
    try {
      Response response = await _networkService.post(
        url: uRLLogin,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
