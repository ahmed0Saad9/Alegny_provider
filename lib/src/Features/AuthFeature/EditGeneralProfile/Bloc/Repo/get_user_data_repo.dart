import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:Alegny_provider/src/core/constants/api_key.dart';
import 'package:Alegny_provider/src/core/services/Network/api_result.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/Network/network_services.dart';

class GetUserDataRepository with ApiKey {
  final NetworkService _networkService = Get.find();

  Future<ApiResult<Response>> getUserData() async {
    try {
      Response response = await _networkService.get(
        url: 'uRLGetUserData',
        auth: true,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
