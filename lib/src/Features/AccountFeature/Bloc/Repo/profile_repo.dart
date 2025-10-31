import 'package:Alegny_provider/src/core/constants/api_key.dart';
import 'package:Alegny_provider/src/core/services/Network/api_result.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/Network/network_services.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';
import 'package:dio/dio.dart';

class ProfileRepo with ApiKey {
  final NetworkService _networkService = sl<NetworkService>();

  Future<ApiResult<Response>> getUserData({
    required int universityIDCard,
  }) async {
    try {
      Response response = await _networkService.get(
        url: uRLProfile(universityIDCard: universityIDCard),
        auth: true,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
