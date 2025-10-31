import 'package:dio/dio.dart';
import 'package:Alegny_provider/src/Features/HomeFeature/Bloc/model/subjects_model.dart';
import 'package:Alegny_provider/src/core/constants/api_key.dart';
import 'package:Alegny_provider/src/core/services/Network/api_result.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/Network/network_services.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';

class SubjectsRepository with ApiKey {
  final NetworkService _networkService = sl<NetworkService>();

  Future<ApiResult<List<Subjects>>> getAllSubjects(
      {required int academicYear, required String search}) async {
    try {
      Response response = await _networkService.get(
        //the service that runs the Api and get data based on the params(academicYear,search)
        url: uRLGetAllSubjects(academicYear: academicYear, search: search),
      );
      return ApiResult.success(
          List.from(response.data).map((e) => Subjects.fromJson(e)).toList());
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
