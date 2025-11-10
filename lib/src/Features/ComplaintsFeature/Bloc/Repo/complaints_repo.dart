// lib/src/Features/ComplaintsFeature/Bloc/Repo/complaint_repository.dart
import 'package:Alegny_provider/src/Features/ComplaintsFeature/Bloc/Params/complains_param.dart';
import 'package:Alegny_provider/src/core/constants/api_key.dart';
import 'package:Alegny_provider/src/core/services/Network/network_services.dart';
import 'package:dio/dio.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/Network/api_result.dart';
import 'package:get/instance_manager.dart';

class ComplaintRepository with ApiKey {
  final NetworkService _networkService = Get.find();

  Future<ApiResult<Response>> submitComplaint({
    required ComplaintParams param,
  }) async {
    try {
      FormData formData = await param.toFormData();

      Response response = await _networkService.post(
        url: uRLAddComplain,
        auth: true,
        bodyFormData: formData,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
