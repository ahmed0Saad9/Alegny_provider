import 'dart:io';

import 'package:Alegny_provider/src/Features/AddServiceFeature/Bloc/Model/add_service_model.dart';
import 'package:Alegny_provider/src/Features/HomeFeature/Bloc/Repo/get_services_repo.dart';
import 'package:Alegny_provider/src/Features/HomeFeature/Bloc/model/service_model.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/services/Base/base_controller.dart';
import 'package:Alegny_provider/src/core/services/Network/api_result.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ServicesController extends BaseController<ServicesRepository> {
  @override
  get repository => sl<ServicesRepository>();

  final List<ServiceModel> _services = [];
  List<ServiceModel> get services => _services;

  @override
  void onInit() async {
    await fetchServices();
    super.onInit();
  }

  Future<void> fetchServices() async {
    _services.clear();
    reInitPagination();
    showLoading();
    update();

    var result = await repository!.getServices();

    result.when(success: (List<ServiceModel> ourPartner) {
      incrementPageNumber(ourPartner.isNotEmpty);
      _services.addAll(ourPartner);
      doneLoading();
      update();
    }, failure: (NetworkExceptions error) {
      errorLoading();
      status = actionNetworkExceptions(error);
      update();
    });
  }

  // Get service details for editing
  Future<ServiceModel?> getServiceForEditing(String serviceId) async {
    try {
      showEasyLoading();

      final result = await repository!.getServiceDetails(serviceId);

      closeEasyLoading();

      return result.when(
        success: (service) => service,
        failure: (error) {
          actionNetworkExceptions(error);
          return null;
        },
      );
    } catch (e) {
      closeEasyLoading();
      errorEasyLoading('failed_to_load_service'.tr);
      return null;
    }
  }

  // Update service
  Future<bool> updateService({
    required String serviceId,
    required ServiceData serviceData,
    File? imageFile,
  }) async {
    try {
      showEasyLoading();

      final result = await repository!.updateService(
        serviceId: serviceId,
        serviceData: serviceData.toJson(),
        imageFile: imageFile,
      );

      closeEasyLoading();

      return result.when(
        success: (response) {
          // Update the service in the local list
          final updatedService = ServiceModel.fromJson(response.data);
          final index = _services.indexWhere((s) => s.id == serviceId);
          if (index != -1) {
            _services[index] = updatedService;
          }

          successEasyLoading(
            response.data['message'] ?? 'service_updated_successfully'.tr,
          );

          update();
          return true;
        },
        failure: (error) {
          actionNetworkExceptions(error);
          return false;
        },
      );
    } catch (e) {
      closeEasyLoading();
      errorEasyLoading('failed_to_update_service'.tr);
      return false;
    }
  }

  // Delete service method
  Future<void> deleteService(String serviceId) async {
    try {
      showEasyLoading();

      final result = await repository!.deleteService(serviceId);

      closeEasyLoading();

      result.when(
        success: (response) {
          _services.removeWhere((service) => service.id == serviceId);
          successEasyLoading(
            response.data['message'] ?? 'service_deleted_successfully'.tr,
          );
          update();
        },
        failure: (error) {
          actionNetworkExceptions(error);
        },
      );
    } catch (e) {
      closeEasyLoading();
      errorEasyLoading('failed_to_delete_service'.tr);
    }
  }

  // Show delete confirmation
  void showDeleteConfirmation(String serviceId, String serviceName) {
    Get.dialog(
      AlertDialog(
        title: CustomTextL(
          'delete_service'.tr,
          fontSize: 18.sp,
          fontWeight: FW.bold,
        ),
        content: CustomTextL(
          '${'are_you_sure_you_want_to_delete'.tr} "$serviceName"?',
          fontSize: 16.sp,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: CustomTextL(
              'cancel'.tr,
              color: Colors.grey,
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              deleteService(serviceId);
            },
            child: CustomTextL(
              'delete'.tr,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
