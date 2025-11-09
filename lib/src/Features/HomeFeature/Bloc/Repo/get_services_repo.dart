import 'dart:convert';
import 'dart:io';

import 'package:Alegny_provider/src/Features/HomeFeature/Bloc/model/service_model.dart';
import 'package:Alegny_provider/src/core/constants/api_key.dart';
import 'package:Alegny_provider/src/core/services/Network/api_result.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/Network/network_services.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';
import 'package:dio/dio.dart';

class ServicesRepository with ApiKey {
  final NetworkService _networkService = sl<NetworkService>();

  Future<ApiResult<List<ServiceModel>>> getServices() async {
    try {
      final response = await _networkService.get(
        url: uRLGetServices,
        auth: true,
      );

      final data = response.data as List;
      final services = data.map((e) => ServiceModel.fromJson(e)).toList();

      return ApiResult.success(services);
    } catch (error) {
      return ApiResult.failure(NetworkExceptions.getDioException(error));
    }
  }

  Future<ApiResult<Response>> deleteService(String serviceId) async {
    try {
      final response = await _networkService.delete(
        url: uRLDeleteService(serviceId: serviceId),
        auth: true,
      );

      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  // NEW: Get service details for editing
  Future<ApiResult<ServiceModel>> getServiceDetails(String serviceId) async {
    try {
      final response = await _networkService.get(
        url: uRLEditService(serviceId: serviceId),
        auth: true,
      );

      final service = ServiceModel.fromJson(response.data);
      return ApiResult.success(service);
    } catch (error) {
      return ApiResult.failure(NetworkExceptions.getDioException(error));
    }
  }

  // NEW: Update service
  Future<ApiResult<Response>> updateService({
    required String serviceId,
    required Map<String, dynamic> serviceData,
    File? imageFile,
  }) async {
    try {
      // If there's an image, use form-data, otherwise use JSON
      if (imageFile != null) {
        final formData = FormData.fromMap({
          'serviceDataJson': jsonEncode(serviceData),
          'image': await MultipartFile.fromFile(imageFile.path),
        });

        final response = await _networkService.put(
          url: uRLUpdateServiceService(
              serviceId: serviceId), // Adjust URL based on your API
          bodyFormData: formData,
          auth: true,
        );

        return ApiResult.success(response);
      } else {
        final response = await _networkService.put(
          url: uRLGetServiceDetailsService(serviceId: serviceId),
          body: serviceData,
          auth: true,
        );

        return ApiResult.success(response);
      }
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
