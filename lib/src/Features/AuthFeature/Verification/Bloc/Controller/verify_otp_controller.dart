import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Verification/Bloc/Repo/verify_otp_repository.dart';
import 'package:Alegny_provider/src/core/services/Base/base_controller.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';
import 'package:Alegny_provider/src/core/utils/storage_util.dart';

class VerifyOTPController extends BaseController<VerifyOTPRepository> {
  @override
  // TODO: implement repository
  get repository => sl<VerifyOTPRepository>();

  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  Future<void> verify({required String token}) async {
    if (textEditingController.text.length == 4) {
      showEasyLoading();
      var result = await repository!.verifyOTP(
        otp: textEditingController.text,
        token: token,
      );
      closeEasyLoading();

      result.when(success: (Response response) {
        LocalStorageCubit().saveItem(key: 'verified', item: true);
      }, failure: (NetworkExceptions error) {
        actionNetworkExceptions(error);
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    textEditingController = TextEditingController();
    errorController = StreamController<ErrorAnimationType>();
  }
}
