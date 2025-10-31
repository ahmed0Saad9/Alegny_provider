// import 'package:flutter/material.dart';
// import 'package:Alegny/src/Features/AuthFeature/EditGeneralProfile/Bloc/Repo/account_details_repo.dart';
// import 'package:Alegny/src/core/services/Base/base_controller.dart';
// import 'package:Alegny/src/core/services/Network/network_exceptions.dart';
// import 'package:Alegny/src/core/services/services_locator.dart';
//
// class AccountDetailsController
//     extends BaseController<AccountDetailsRepository> {
//   @override
//   // TODO: implement repository
//   get repository => sl<AccountDetailsRepository>();
//   TextEditingController searchController = TextEditingController();
//   @override
//   void onInit() async {
//     // TODO: implement onInit
//     await getAccountDetails();
//     super.onInit();
//   }
//
//   final List<AccountDetailsModel> _accountDetailsModel = [];
//
//   List<AccountDetailsModel> get accountDetailsModel => _accountDetailsModel;
//
//   Future<void> getAccountDetails() async {
//     _accountDetailsModel.clear();
//     reInitPagination();
//     showLoading();
//
//     update();
//
//     var result = await repository!.getAccountDetails(
//       pageNum: page,
//       keySearch: searchController.text,
//     );
//
//     result.when(success: (List<AccountDetailsModel> accountDetails) {
//       incrementPageNumber(accountDetails.isNotEmpty);
//       _accountDetailsModel.addAll(accountDetails);
//       doneLoading();
//       update();
//     }, failure: (NetworkExceptions error) {
//       errorLoading();
//       status = actionNetworkExceptions(error);
//       update();
//     });
//   }
// }
