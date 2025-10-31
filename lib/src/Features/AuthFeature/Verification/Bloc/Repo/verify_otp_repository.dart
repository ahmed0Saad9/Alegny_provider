import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:Alegny_provider/src/core/constants/api_key.dart';
import 'package:Alegny_provider/src/core/services/Network/api_result.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/Network/network_services.dart';

class VerifyOTPRepository with ApiKey {
  final NetworkService _networkService = Get.find();

  Future<ApiResult<Response>> verifyOTP({
    required String otp,
    required String token,
  }) async {
    Response response;
    try {
      response = await _networkService.post(
          url: uRLVerifyAccountOtp,
          auth: true,
          body: {"verify_token": token, "otp": otp});
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
