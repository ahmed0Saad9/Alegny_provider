// import 'package:dio/dio.dart';
// import 'package:Alegny/src/Features/AuthFeature/EditGeneralProfile/Bloc/model/account_details_model.dart';
// import 'package:Alegny/src/core/constants/api_key.dart';
// import 'package:Alegny/src/core/services/Network/api_result.dart';
// import 'package:Alegny/src/core/services/Network/network_exceptions.dart';
// import 'package:Alegny/src/core/services/Network/network_services.dart';
// import 'package:Alegny/src/core/services/services_locator.dart';
//
// class AccountDetailsRepository with ApiKey {
//   final NetworkService _networkService = sl<NetworkService>();
//
//   Future<ApiResult<List<AccountDetailsModel>>> getAccountDetails(
//       {required int pageNum, String? keySearch}) async {
//     try {
//       Response response = await _networkService.get(
//         // url: uRLAccount,
//         auth: true,
//         queryParams: {
//           if (keySearch != null && keySearch.isNotEmpty) 'search': keySearch,
//         },
//       );
//       return ApiResult.success(List.from(response.data['data'])
//           .map((e) => AccountDetailsModel.fromJson(e))
//           .toList());
//     } catch (e) {
//       return ApiResult.failure(NetworkExceptions.getDioException(e));
//     }
//   }
// }
