import 'dart:io';

import 'package:Alegny_provider/src/core/constants/api_key.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart' as path;
import '../../utils/network_exceptions.dart';

class NetworkService with ApiKey {
  Dio dio = Dio();

  NetworkService() {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    if (kDebugMode) {
      dio.interceptors.add(sl<LogInterceptor>());
    }
  }

  Future<Response> get({
    @required String? url,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    bool auth = false,
    bool profileID = false,
  }) async {
    Response? response;
    //TODO fetch api token here and save it in apiToken
    try {
      dio.options.baseUrl = ApiKey.apiBaseUrl;
      response = await dio.get(
        url!,
        options: Options(
            headers: headers ??
                {
                  "Accept": "application/json",
                  "X-Language": sl<GetStorage>().read('X-Language'),
                  if (auth)
                    // 'Authorization':
                    //     'Bearer 39|G5enxqiHngDT6uY4NGQY52S0o65n3wKj1WDe0pXk19ece3de',
                    'Authorization': 'Bearer ${sl<GetStorage>().read("token")}',
                  if (profileID)
                    'ProfileID': sl<GetStorage>().read("ProfileID"),
                }),
        queryParameters: queryParams,
      );
      return response;
    } on DioError catch (e) {
      if (e.toString().contains('SocketException')) {
        throw NetworkDisconnectException('لا يوجد اتصال بالانترنت');
      }
      if (e.response != null) {
        if (e.response.toString().contains('SocketException')) {
          throw NetworkDisconnectException('لا يوجد اتصال بالانترنت');
        }
      }
      if (e.response != null) {
        response = e.response;
      }
      throw e;
    }
    // return handleResponse(response!);
  }

  Future<Response> post(
      {@required String? url,
      Map<String, String>? headers,
      Map<String, dynamic>? body,
      FormData? bodyFormData,
      bool isForm = false,
      int? contentLength,
      String fileKey = '',
      Map<String, dynamic>? queryParams,
      bool auth = false,
      List<File>? fileList,
      String imagesKey = ''}) async {
    Response? response;
    dio.options.baseUrl = ApiKey.apiBaseUrl;
    FormData formData = FormData.fromMap(
      body ?? {},
    );
    /*** handle upload images ***/
    if (fileList != null && fileList.isNotEmpty) {
      for (File item in fileList) {
        formData.files.add(
          MapEntry(
            fileKey,
            await MultipartFile.fromFile(
              item.path,
              filename: path.basename(item.path),
            ),
          ),
        );
      }
    }
    try {
      response = await dio.post(
        url!,
        data: (isForm && fileList != null && fileList.isNotEmpty)
            ? formData
            : (bodyFormData != null)
                ? bodyFormData
                : body,
        options: Options(
          headers: headers ??
              {
                if (contentLength != null)
                  'Content-Length': contentLength
                      .toString(), // Set the correct contentLength here
                "Accept": "application/json",
                "X-Language": sl<GetStorage>().read('X-Language'),

                if (auth)
                  // 'Authorization':
                  //     'Bearer 39|G5enxqiHngDT6uY4NGQY52S0o65n3wKj1WDe0pXk19ece3de',
                  'Authorization': 'Bearer ${sl<GetStorage>().read('token')}',
              },
          // requestEncoder: encoding,
        ),
        queryParameters: queryParams,
      );
      return response;
    } on DioError catch (e) {
      if (e.toString().contains('SocketException')) {
        throw NetworkDisconnectException('لا يوجد اتصال بالانترنت');
      }
      if (e.response != null) {
        if (e.response.toString().contains('SocketException')) {
          throw NetworkDisconnectException('لا يوجد اتصال بالانترنت');
        }
      }
      if (e.response != null) {
        response = e.response;
      }
      throw e;
    }

    // return handleResponse(response!);
  }

  Future<Response> put({
    @required String? url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    FormData? bodyFormData,
    bool isForm = false,
    int? contentLength,
    String fileKey = '',
    Map<String, dynamic>? queryParams,
    bool auth = false,
    List<File>? fileList,
    String imagesKey = '',
  }) async {
    Response? response;
    dio.options.baseUrl = ApiKey.apiBaseUrl;
    FormData formData = FormData.fromMap(body ?? {});

    /*** handle upload images ***/
    if (fileList != null && fileList.isNotEmpty) {
      for (File item in fileList) {
        formData.files.add(
          MapEntry(
            fileKey.isNotEmpty ? fileKey : 'file',
            await MultipartFile.fromFile(
              item.path,
              filename: path.basename(item.path),
            ),
          ),
        );
      }
    }

    try {
      response = await dio.put(
        url!,
        data: (isForm && fileList != null && fileList.isNotEmpty)
            ? formData
            : (bodyFormData != null)
                ? bodyFormData
                : body,
        options: Options(
          headers: headers ??
              {
                if (contentLength != null)
                  'Content-Length': contentLength.toString(),
                "Accept": "application/json",
                "X-Language": sl<GetStorage>().read('X-Language'),
                if (auth)
                  'Authorization': 'Bearer ${sl<GetStorage>().read("token")}',
              },
        ),
        queryParameters: queryParams,
      );
      return response;
    } on DioError catch (e) {
      if (e.toString().contains('SocketException')) {
        throw NetworkDisconnectException('لا يوجد اتصال بالانترنت');
      }
      if (e.response != null) {
        if (e.response.toString().contains('SocketException')) {
          throw NetworkDisconnectException('لا يوجد اتصال بالانترنت');
        }
      }
      if (e.response != null) {
        response = e.response;
      }
      throw e;
    }
  }

  Future<Response> delete({
    @required String? url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    bool auth = false,
  }) async {
    Response? response;
    dio.options.baseUrl = ApiKey.apiBaseUrl;
    try {
      response = await dio.delete(
        url!,
        data: body,
        options: Options(
            headers: headers ??
                {
                  "Accept": "application/json",
                  "X-Language": sl<GetStorage>().read('X-Language'),
                  if (auth)
                    'Authorization': 'Bearer ${sl<GetStorage>().read("token")}',
                }),
        queryParameters: queryParams,
      );
      return response;
    } on DioError catch (e) {
      if (e.toString().contains('SocketException')) {
        throw NetworkDisconnectException('لا يوجد اتصال بالانترنت');
      }
      if (e.response != null) {
        if (e.response.toString().contains('SocketException')) {
          throw NetworkDisconnectException('لا يوجد اتصال بالانترنت');
        }
      }
      if (e.response != null) {
        response = e.response;
      }
      throw e;
    }
    // return handleResponse(response!);
  }

// Response handleResponse(Response response) {
//
//   final int statusCode = response.statusCode ?? 500;
//   // if(statusCode==HttpStatus.unauthorized){
//   //   throw ServerSideException('server side exception');
//   // }
//   if (statusCode == 500) {
//     throw ServerSideException('server side exception');
//   }
//   if (statusCode == 200) {
//     return response;
//   } else {
//     return response;
//   }
// }
}
