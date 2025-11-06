import 'package:dio/dio.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/instance_manager.dart';
import 'package:Alegny_provider/src/core/constants/api_key.dart';
import 'package:Alegny_provider/src/core/constants/app_assets.dart';
import 'package:Alegny_provider/src/core/services/Network/api_result.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/Network/network_services.dart';

class LogInRepository with ApiKey {
  final NetworkService _networkService = Get.find();
  // final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<ApiResult<Response>> logIn({
    required String email,
    required String password,
  }) async {
    // String? token = '';
    // try {
    //   token = await _fcm.getToken();
    //   printDM("device_key is => $token");
    // } catch (e) {
    //   printDM('an error occur in fetch token');
    // }
    try {
      Response response = await _networkService.post(url: uRLLogin, body: {
        'email': email,
        'password': password,
      });
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
