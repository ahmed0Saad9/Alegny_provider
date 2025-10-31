import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Bloc/Params/register_params.dart';
import 'package:Alegny_provider/src/core/constants/api_key.dart';
import 'package:Alegny_provider/src/core/services/Network/api_result.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/Network/network_services.dart';

class RegisterRepository with ApiKey {
  final NetworkService _networkService = Get.find();

  // final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  Future<ApiResult<Response>> register({
    required RegisterParams registerParams,
  }) async {
    // String? token = '';
    // try {
    //   token = await _fcm.getToken();
    // } catch (e) {
    //   printDM('an error occur in fetch token');
    // }
    try {
      Response response = await _networkService.post(
        url: uRLRegister,
        body: await registerParams.toMap(),
        // bodyFormData: await registerParams.toFormData(),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
