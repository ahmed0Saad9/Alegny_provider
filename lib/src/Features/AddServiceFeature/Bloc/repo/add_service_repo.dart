import 'dart:convert';
import 'dart:io';
import 'package:Alegny_provider/src/Features/AddServiceFeature/Bloc/Model/add_service_model.dart';
import 'package:Alegny_provider/src/core/services/Network/api_result.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/Network/network_services.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

import '../../../../core/constants/api_key.dart';

class CreateServiceRepository with ApiKey {
  final NetworkService _networkService = Get.find();

  Future<ApiResult<Response>> createService(ServiceData param) async {
    try {
      print('=== REPOSITORY DEBUG START ===');

      // DEBUG 1: Check the raw ServiceData
      print('1. ServiceData fields:');
      print('   serviceName: ${param.serviceName}');
      print('   serviceType: ${param.serviceType}');
      print(
          '   isHomeService: ${param.isHomeService} (type: ${param.isHomeService.runtimeType})');

      // DEBUG 2: Check the toJson() output
      final serviceDataMap = param.toJson();
      print('2. ServiceData.toJson() output:');
      print('   Type: ${serviceDataMap.runtimeType}');
      print('   Keys: ${serviceDataMap.keys}');
      print('   is_home_service value: ${serviceDataMap['is_home_service']}');
      print(
          '   is_home_service type: ${serviceDataMap['is_home_service']?.runtimeType}');

      // DEBUG 3: Check JSON encoding
      try {
        final serviceDataJson = jsonEncode(serviceDataMap);
        print('3. JSON encode successful!');
        print('   JSON length: ${serviceDataJson.length}');
        print(
            '   First 200 chars: ${serviceDataJson.substring(0, serviceDataJson.length < 200 ? serviceDataJson.length : 200)}');
      } catch (e) {
        print('3. JSON ENCODE ERROR: $e');
        print('   Error type: ${e.runtimeType}');

        // Find the problematic field
        _findProblematicField(serviceDataMap);
        return ApiResult.failure(NetworkExceptions.getDioException(e));
      }

      // Prepare form data
      final formData = FormData.fromMap({
        'coverImage': param.serviceImage != null
            ? await MultipartFile.fromFile(
                param.serviceImage!.path,
                filename: param.serviceImage!.path,
              )
            : null,
        'serviceDataJson':
            jsonEncode(serviceDataMap), // This is the double encoding
      });

      print('4. FormData prepared');
      print('   FormData fields: ${formData.fields}');
      print('   FormData files: ${formData.files}');

      // Send request
      final response = await _networkService.post(
        url: uRLAddService,
        auth: true,
        bodyFormData: formData,
      );

      print('5. API Response:');
      print('   Status: ${response.statusCode}');
      print('   Data: ${response.data}');
      print('=== REPOSITORY DEBUG END ===');

      return ApiResult.success(response);
    } catch (e) {
      print('=== REPOSITORY ERROR ===');
      print('Error: $e');
      print('Error type: ${e.runtimeType}');
      if (e is DioError) {
        print('Dio error type: ${e.type}');
        print('Dio error message: ${e.message}');
        print('Dio response: ${e.response?.data}');
      }
      print('======================');
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  void _findProblematicField(Map<String, dynamic> data) {
    print('=== FINDING PROBLEMATIC FIELD ===');

    // Test each field individually
    for (final entry in data.entries) {
      try {
        final testMap = {entry.key: entry.value};
        jsonEncode(testMap);
        print(
            '   ✓ ${entry.key}: OK (value: ${entry.value}, type: ${entry.value.runtimeType})');
      } catch (e) {
        print('   ✗ ${entry.key}: ERROR - $e');
        print('      Value: ${entry.value}');
        print('      Type: ${entry.value.runtimeType}');
      }
    }
  }

  Future<ApiResult<Response>> updateService({
    required String serviceId,
    required ServiceData serviceData,
    File? imageFile,
  }) async {
    try {
      // If there's an image, use form-data, otherwise use JSON
      if (imageFile != null) {
        final formData = FormData.fromMap({
          'serviceDataJson': jsonEncode(serviceData.toJson()),
          'image': await MultipartFile.fromFile(imageFile.path),
        });

        final response = await _networkService.put(
          url: uRLUpdateServiceService(serviceId: serviceId),
          bodyFormData: formData,
          auth: true,
        );

        return ApiResult.success(response);
      } else {
        final response = await _networkService.put(
          url: uRLUpdateServiceService(serviceId: serviceId),
          body: serviceData.toJson(),
          auth: true,
        );

        return ApiResult.success(response);
      }
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
