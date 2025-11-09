import 'package:Alegny_provider/src/Features/AuthFeature/EditGeneralProfile/Bloc/model/personal_data_model.dart';
import 'package:Alegny_provider/src/core/constants/api_key.dart';
import 'package:Alegny_provider/src/core/services/Network/api_result.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/Network/network_services.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class AccountDetailsRepository with ApiKey {
  final NetworkService _networkService = sl<NetworkService>();

  Future<ApiResult<Response>> getAccountDetails() async {
    try {
      Response response = await _networkService.get(
        url: uRLGetMyAccountData,
        auth: true,
        headers: {'Authorization': 'Bearer ${sl<GetStorage>().read('token')}'},
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
