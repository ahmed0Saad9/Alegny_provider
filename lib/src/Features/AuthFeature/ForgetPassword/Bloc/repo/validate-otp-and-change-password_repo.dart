import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:Alegny_provider/src/core/constants/api_key.dart';
import 'package:Alegny_provider/src/core/services/Network/api_result.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/Network/network_services.dart';

class ValidateOtpAndChangePasswordRepo with ApiKey {
  final NetworkService _networkService = Get.find();

  Future<ApiResult<Response>> validateOtpAndChangePassword({
    required String verifyToken,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await _networkService.post(
        url: uRLValidateOtpAndChangePassword,
        body: {
          "verify_token": verifyToken,
          "otp": otp,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
