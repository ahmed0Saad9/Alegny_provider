import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:Alegny_provider/src/core/constants/api_key.dart';
import 'package:Alegny_provider/src/core/services/Network/api_result.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/Network/network_services.dart';

class ValidateOtpAndChangePasswordRepo with ApiKey {
  final NetworkService _networkService = Get.find();

  Future<ApiResult<Response>> validateOtpAndChangePassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      final response = await _networkService.post(
        url: uRLResetPassword, // Make sure this URL is correct
        body: {
          "email": email,
          "code": code,
          "newPassword": newPassword,
          "confirmNewPassword": confirmNewPassword,
        },
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
