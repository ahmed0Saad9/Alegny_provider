import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/EditGeneralProfile/Bloc/Params/edit_general_profile_params.dart';
import 'package:Alegny_provider/src/core/constants/api_key.dart';
import 'package:Alegny_provider/src/core/services/Network/api_result.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/Network/network_services.dart';

class EditGeneralProfileRepository with ApiKey {
  final NetworkService _networkService = Get.find();

  Future<ApiResult<Response>> updateProfile({
    required EditProfileParam param,
  }) async {
    try {
      Response response = await _networkService.post(
        url: uRLUpdateMyAccountData,
        auth: true,
        // bodyFormData:await param.toFormData(),
        // body: param.toMap(),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
