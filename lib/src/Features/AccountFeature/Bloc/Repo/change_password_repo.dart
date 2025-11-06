import 'package:Alegny_provider/src/Features/AccountFeature/Bloc/params/reset_password_params.dart';
import 'package:Alegny_provider/src/core/constants/api_key.dart';
import 'package:Alegny_provider/src/core/services/Network/api_result.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/Network/network_services.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class ChangePasswordRepository with ApiKey {
  final NetworkService _networkService = sl<NetworkService>();

  Future<ApiResult<Response>> postChangePassword(
      {required ResetPasswordParams resetPasswordParams}) async {
    try {
      Response response = await _networkService.post(
          url: uRLChangePassword,
          auth: true,
          headers: {
            'Authorization': 'Bearer ${sl<GetStorage>().read('token')}'
          },
          body: resetPasswordParams.toMap());
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
