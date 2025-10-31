import 'package:dio/dio.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Bloc/Model/company_category_model.dart';
import 'package:Alegny_provider/src/core/constants/api_key.dart';
import 'package:Alegny_provider/src/core/services/Network/api_result.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/Network/network_services.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';

class GetCompanyCategoriesRepository with ApiKey {
  final NetworkService _networkService = sl<NetworkService>();

  Future<ApiResult<BaseCategoryModel>> getCompanyCategories(
      {int? pageNum}) async {
    try {
      Response response = await _networkService.get(url: '', queryParams: {
        "pageNum": pageNum,
      });
      return ApiResult.success(BaseCategoryModel.fromMap(response.data));
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
