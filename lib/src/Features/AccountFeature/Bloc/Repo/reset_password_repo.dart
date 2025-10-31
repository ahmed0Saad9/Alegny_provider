import 'package:Alegny_provider/src/Features/AccountFeature/Bloc/params/reset_password_params.dart';
import 'package:Alegny_provider/src/core/constants/api_key.dart';
import 'package:Alegny_provider/src/core/services/Network/api_result.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/Network/network_services.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';
import 'package:dio/dio.dart';

class ResetPasswordRepository with ApiKey {
  final NetworkService _networkService = sl<NetworkService>();

  Future<ApiResult<Response>> postResetPassword(
      {required ResetPasswordParams resetPasswordParams}) async {
    try {
      Response response = await _networkService.post(
          url: uRLResetPassword, auth: true, body: resetPasswordParams.toMap());
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
