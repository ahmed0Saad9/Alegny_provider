import 'package:Alegny_provider/src/Features/AccountFeature/Bloc/Repo/change_password_repo.dart';
import 'package:Alegny_provider/src/Features/AccountFeature/Bloc/params/reset_password_params.dart';
import 'package:Alegny_provider/src/Features/AccountFeature/UI/widgets/password_updated_dialog.dart';
import 'package:Alegny_provider/src/core/services/Base/base_controller.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

class ChangePasswordController
    extends BaseController<ChangePasswordRepository> {
  @override
  // TODO: implement repository
  get repository => sl<ChangePasswordRepository>();

  late TextEditingController currentPasswordController;

  late TextEditingController newPasswordController;

  late TextEditingController confirmPasswordController;

  @override
  void onInit() {
    // TODO: implement onInit
    _initTextEditController();
    super.onInit();
  }

  void _initTextEditController() {
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  final GlobalKey<FormState> resetPasswordKey = GlobalKey<FormState>();

  Future<void> changePassword() async {
    if (resetPasswordKey.currentState!.validate()) {
      resetPasswordKey.currentState!.save();
      showEasyLoading();
      var result = await repository!.postChangePassword(
        resetPasswordParams: ResetPasswordParams(
          currentPassword: currentPasswordController.text,
          newPassword: newPasswordController.text,
          confirmNewPassword: confirmPasswordController.text,
        ),
      );
      closeEasyLoading();
      result.when(success: (Response response) {
        Get.dialog(
          PasswordUpdatedDialog(),
        );
      }, failure: (NetworkExceptions error) {
        actionNetworkExceptions(error);
      });
    }
  }
}
