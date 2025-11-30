// verify_otp_repo.dart
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:Alegny_provider/src/core/constants/api_key.dart';
import 'package:Alegny_provider/src/core/services/Network/api_result.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/Network/network_services.dart';

class VerifyOtpRepo with ApiKey {
  final NetworkService _networkService = Get.find();

  Future<ApiResult<Response>> verifyOtp({
    required String email,
    required String code,
  }) async {
    try {
      final response = await _networkService.post(
        url:
            uRLVerifyOtp, // Make sure this constant points to /api/v1/provider-auth/verify-otp
        body: {
          "email": email,
          "code": code,
        },
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
